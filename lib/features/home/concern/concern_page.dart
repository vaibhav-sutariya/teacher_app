import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../core/widgets/app_app_bar.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/widgets/end_of_list_indicator.dart';
import '../../../../core/widgets/app_tab_bar.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../../../../cubit/theme_cubit.dart';
import '../../../core/routes/app_router.gr.dart';
import 'bloc/concern_bloc.dart';
import 'widgets/concern_item.dart';

@RoutePage()
class ConcernPage extends StatelessWidget {
  const ConcernPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConcernBloc()..add(LoadConcerns()),
      child: const ConcernPageContent(),
    );
  }
}

class ConcernPageContent extends StatelessWidget {
  const ConcernPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppAppBar(
        title: 'My Concerns',
        profileImageUrl: 'https://i.pravatar.cc/300', // Placeholder
      ),
      body: Column(
        children: [
          // Tab Bar
          BlocSelector<ConcernBloc, ConcernState, int>(
            selector: (state) {
              if (state is ConcernLoaded) {
                return state.selectedTabIndex;
              }
              return 0;
            },
            builder: (context, selectedIndex) {
              return AppTabBar(
                tabs: const ['Open', 'In Process', 'Closed'],
                selectedIndex: selectedIndex,
                onTabChanged: (index) {
                  context.read<ConcernBloc>().add(FilterConcerns(index));
                },
              );
            },
          ),

          Expanded(
            child: BlocBuilder<ConcernBloc, ConcernState>(
              builder: (context, state) {
                if (state is ConcernLoading) {
                  return const Center(child: AppLoader());
                } else if (state is ConcernError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else if (state is ConcernLoaded) {
                  if (state.filteredConcerns.isEmpty) {
                    return _buildEmptyState(context);
                  }

                  return ListView.builder(
                    padding: EdgeInsets.all(context.scale(16)),
                    itemCount: state.filteredConcerns.length + 1,
                    itemBuilder: (context, index) {
                      if (index == state.filteredConcerns.length) {
                        return const EndOfListIndicator();
                      }
                      return ConcernItem(
                        concern: state.filteredConcerns[index],
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await context.router.push(const AddConcernRoute());
          if (result == true && context.mounted) {
            showFlushbar(
              context: context,
              message: 'Concern submitted successfully',
              isError: false,
            );
          }
        },
        backgroundColor: context.colors.primary,
        foregroundColor: Colors.white,
        elevation: 4,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: context.scale(48),
            color: Colors.grey[400],
          ),
          SizedBox(height: context.scaleHeight(16)),
          Text(
            'No concerns found',
            style: TextStyle(
              fontSize: context.scaleFont(16),
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
