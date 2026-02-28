import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../core/routes/app_router.gr.dart';
import '../../../../core/widgets/app_app_bar.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/widgets/end_of_list_indicator.dart';
import '../../../../core/widgets/error_state.dart';
import 'bloc/gallery_bloc.dart';
import 'bloc/gallery_event.dart';
import 'bloc/gallery_state.dart';
import 'models/gallery_model.dart';
import 'widgets/gallery_card.dart';

/// Production-ready gallery page
/// Optimized for performance with proper state management using BLoC
@RoutePage()
class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GalleryBloc(),
      child: const _GalleryPageContent(),
    );
  }
}

class _GalleryPageContent extends StatelessWidget {
  const _GalleryPageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppAppBar(
        title: 'Gallery',
        profileImageUrl: 'https://i.pravatar.cc/150?u=a042581f4e29026024d',
      ),
      body: BlocSelector<GalleryBloc, GalleryState, bool>(
        selector: (state) => state.isLoading && state.galleryList.isEmpty,
        builder: (context, isLoading) {
          if (isLoading) {
            return const Center(child: AppLoader());
          }
          return const _GalleryBody();
        },
      ),
    );
  }
}

/// Separated body widget to optimize rebuilds
class _GalleryBody extends StatelessWidget {
  const _GalleryBody();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<GalleryBloc, GalleryState, String?>(
      selector: (state) => state.errorMessage,
      builder: (context, errorMessage) {
        if (errorMessage != null) {
          return ErrorState(
            message: errorMessage,
            onRetry: () =>
                context.read<GalleryBloc>().add(const RefreshGalleryEvent()),
          );
        }
        return const _GalleryContent();
      },
    );
  }
}

/// Main content widget with gallery grid and pagination
/// Optimized for high performance with granular rebuilds using BlocSelector
class _GalleryContent extends StatelessWidget {
  const _GalleryContent();

  @override
  Widget build(BuildContext context) {
    return _GalleryScrollView();
  }
}

/// Scroll view with pagination detection
/// Separated to optimize rebuilds
class _GalleryScrollView extends StatelessWidget {
  const _GalleryScrollView();

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        // Load more when user scrolls near the bottom (80%)
        if (scrollInfo.metrics.pixels >=
            scrollInfo.metrics.maxScrollExtent * 0.8) {
          // Read BLoC once to avoid multiple reads
          final bloc = context.read<GalleryBloc>();
          final state = bloc.state;
          if (state.hasMore && !state.isLoadingMore) {
            bloc.add(const LoadMoreGalleryEvent());
          }
        }
        return false;
      },
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<GalleryBloc>().add(const RefreshGalleryEvent());
        },
        child: CustomScrollView(
          cacheExtent: 500.0,
          slivers: [
            // Gallery grid - only rebuilds when galleryList changes
            BlocSelector<GalleryBloc, GalleryState, List<GalleryModel>>(
              selector: (state) => state.galleryList,
              builder: (context, galleryList) {
                if (galleryList.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.photo_library_outlined,
                            size: context.scale(64),
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: context.scaleHeight(16)),
                          Text(
                            'No gallery albums found',
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
                  padding: EdgeInsets.all(context.scale(16)),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: context.scaleHeight(16),
                      crossAxisSpacing: context.scale(16),
                      childAspectRatio:
                          0.72, // Slightly adjusted to prevent overflow
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final gallery = galleryList[index];
                        return RepaintBoundary(
                          key: ValueKey(gallery.id),
                          child: GalleryCard(
                            key: ValueKey('gallery_card_${gallery.id}'),
                            gallery: gallery,
                            onTap: () {
                              context.router.push(
                                GalleryDetailRoute(gallery: gallery),
                              );
                            },
                          ),
                        );
                      },
                      childCount: galleryList.length,
                      // Critical performance optimizations
                      addAutomaticKeepAlives: false,
                      addRepaintBoundaries: true,
                      addSemanticIndexes: false,
                    ),
                  ),
                );
              },
            ),
            // Loading indicator for pagination - only rebuilds when isLoadingMore changes
            BlocSelector<GalleryBloc, GalleryState, bool>(
              selector: (state) => state.isLoadingMore,
              builder: (context, isLoadingMore) {
                if (isLoadingMore) {
                  return SliverToBoxAdapter(
                    child: RepaintBoundary(
                      child: Padding(
                        padding: EdgeInsets.all(context.scaleHeight(16)),
                        child: const AppLoader(),
                      ),
                    ),
                  );
                }
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              },
            ),
            // End of list indicator - only rebuilds when hasMore changes
            BlocSelector<GalleryBloc, GalleryState, bool>(
              selector: (state) =>
                  !state.hasMore && state.galleryList.isNotEmpty,
              builder: (context, showEndIndicator) {
                if (showEndIndicator) {
                  return const SliverToBoxAdapter(child: EndOfListIndicator());
                }
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              },
            ),
            // Bottom padding
            SliverToBoxAdapter(
              child: SizedBox(height: context.scaleHeight(20)),
            ),
          ],
        ),
      ),
    );
  }
}
