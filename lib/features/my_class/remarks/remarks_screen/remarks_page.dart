import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../core/widgets/app_app_bar.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/widgets/end_of_list_indicator.dart';
import '../../../../core/widgets/error_state.dart';
import '../../../../cubit/theme_cubit.dart';
import 'bloc/remark_bloc.dart';
import 'bloc/remark_event.dart';
import 'bloc/remark_state.dart';
import 'models/remark_model.dart';
import 'widgets/remark_card.dart';
import 'widgets/remark_filter_bottom_sheet.dart';

/// Production-ready remarks page
/// Optimized for performance with proper state management using BLoC
@RoutePage()
class RemarksPage extends StatelessWidget {
  const RemarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RemarkBloc(),
      child: const _RemarksPageContent(),
    );
  }
}

class _RemarksPageContent extends StatelessWidget {
  const _RemarksPageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppAppBar(
        title: 'Remarks',
        profileImageUrl: 'https://i.pravatar.cc/150?u=a042581f4e29026024d',
      ),
      body: BlocSelector<RemarkBloc, RemarkState, bool>(
        selector: (state) => state.isLoading && state.remarks.isEmpty,
        builder: (context, isLoading) {
          if (isLoading) {
            return const Center(child: AppLoader());
          }
          return const _RemarksBody();
        },
      ),
      floatingActionButton: _FilterFAB(),
    );
  }
}

/// Floating Action Button for filter
class _FilterFAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<RemarkBloc, RemarkState, bool>(
      selector: (state) => state.hasActiveFilters,
      builder: (context, hasActiveFilters) {
        return FloatingActionButton(
          onPressed: () => _showFilterBottomSheet(context),
          backgroundColor: context.colors.primary,
          child: Stack(
            children: [
              const Icon(Icons.filter_list, color: Colors.white),
              if (hasActiveFilters)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    final bloc = context.read<RemarkBloc>();
    final state = bloc.state;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => RemarkFilterBottomSheet(
        selectedCategories: state.selectedCategories,
        selectedTypes: state.selectedTypes,
        onApplyFilters: (categories, types) {
          bloc.add(ApplyFiltersEvent(categories: categories, types: types));
        },
        onClearFilters: () {
          bloc.add(const ClearFiltersEvent());
        },
      ),
    );
  }
}

/// Separated body widget to optimize rebuilds
class _RemarksBody extends StatelessWidget {
  const _RemarksBody();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RemarkBloc, RemarkState, String?>(
      selector: (state) => state.errorMessage,
      builder: (context, errorMessage) {
        if (errorMessage != null) {
          return ErrorState(
            message: errorMessage,
            onRetry: () =>
                context.read<RemarkBloc>().add(const RefreshRemarksEvent()),
          );
        }
        return const _RemarksContent();
      },
    );
  }
}

/// Main content widget with remarks list and pagination
/// Optimized for high performance with granular rebuilds using BlocSelector
class _RemarksContent extends StatelessWidget {
  const _RemarksContent();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<RemarkBloc>().add(const RefreshRemarksEvent());
        await Future.delayed(const Duration(milliseconds: 600));
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollEndNotification) {
            final scrollMetrics = notification.metrics;
            final bloc = context.read<RemarkBloc>();
            final state = bloc.state;

            // Load more when scrolled near the bottom (80% threshold)
            if (scrollMetrics.pixels >= scrollMetrics.maxScrollExtent * 0.8) {
              if (state.hasMore && !state.isLoadingMore && !state.isLoading) {
                bloc.add(const LoadMoreRemarksEvent());
              }
            }
          }
          return false;
        },
        child: CustomScrollView(
          cacheExtent: 500.0,
          slivers: [
            // Remarks list - only rebuilds when remarks change
            BlocSelector<RemarkBloc, RemarkState, List<RemarkModel>>(
              selector: (state) => state.remarks,
              builder: (context, remarks) {
                if (remarks.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.comment_outlined,
                            size: context.scale(64),
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: context.scaleHeight(16)),
                          Text(
                            'No remarks found',
                            style: TextStyle(
                              fontSize: context.scaleFont(16),
                              color: Colors.grey[600],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return SliverPadding(
                  padding: EdgeInsets.only(top: context.scaleHeight(16)),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final remark = remarks[index];
                        return RepaintBoundary(
                          key: ValueKey('remark_${remark.id}'),
                          child: RemarkCard(remark: remark),
                        );
                      },
                      childCount: remarks.length,
                      // Critical performance optimizations
                      addAutomaticKeepAlives: false,
                      addRepaintBoundaries: true,
                      addSemanticIndexes: false,
                    ),
                  ),
                );
              },
            ),
            // Loading indicator for pagination
            BlocSelector<RemarkBloc, RemarkState, bool>(
              selector: (state) => state.isLoadingMore,
              builder: (context, isLoadingMore) {
                if (!isLoadingMore) {
                  return const SliverToBoxAdapter(child: SizedBox.shrink());
                }
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: context.scaleHeight(8),
                      bottom: context.scaleHeight(8),
                    ),
                    child: const Center(child: AppLoader()),
                  ),
                );
              },
            ),
            // End of list indicator
            BlocSelector<RemarkBloc, RemarkState, bool>(
              selector: (state) => !state.hasMore && state.remarks.isNotEmpty,
              builder: (context, showEndIndicator) {
                if (showEndIndicator) {
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: context.scaleHeight(4),
                        bottom: context.scaleHeight(100), // Space for FAB
                      ),
                      child: EndOfListIndicator(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.scale(20),
                          vertical: context.scaleHeight(12),
                        ),
                      ),
                    ),
                  );
                }
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              },
            ),
          ],
        ),
      ),
    );
  }
}
