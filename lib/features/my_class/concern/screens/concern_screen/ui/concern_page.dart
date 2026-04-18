import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../../../core/widgets/app_app_bar.dart';
import '../../../../../../../core/widgets/app_loader.dart';
import '../../../../../../../core/widgets/end_of_list_indicator.dart';
import '../../../../../../../core/widgets/app_tab_bar.dart';
import '../../../../../../../cubit/theme_cubit.dart';
import '../../../bloc/concern_bloc.dart';
import '../../../models/concern_model.dart';
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
      backgroundColor: context.colors.surface100,
      appBar: const AppAppBar(
        title: 'Student Concerns',
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
            child: BlocSelector<ConcernBloc, ConcernState, bool>(
              selector: (state) => state is ConcernLoading,
              builder: (context, isLoading) {
                if (isLoading) {
                  return const Center(child: AppLoader());
                }
                return const _ConcernList();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ConcernList extends StatelessWidget {
  const _ConcernList();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ConcernBloc, ConcernState, List<ConcernModel>>(
      selector: (state) {
        if (state is ConcernLoaded) return state.filteredConcerns;
        return [];
      },
      builder: (context, filteredConcerns) {
        if (filteredConcerns.isEmpty) {
          return const _EmptyConcerns();
        }

        return ListView.builder(
          padding: EdgeInsets.all(context.scale(16)),
          itemCount: filteredConcerns.length + 1,
          itemBuilder: (context, index) {
            if (index == filteredConcerns.length) {
              return const EndOfListIndicator();
            }
            final concern = filteredConcerns[index];
            return RepaintBoundary(
              key: ValueKey('concern_${concern.id}'),
              child: ConcernItem(concern: concern),
            );
          },
        );
      },
    );
  }
}

class _EmptyConcerns extends StatelessWidget {
  const _EmptyConcerns();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: context.scale(48),
            color: context.colors.textTertiary,
          ),
          SizedBox(height: context.scaleHeight(16)),
          Text(
            'No concerns found',
            style: TextStyle(
              fontSize: context.scaleFont(16),
              color: context.colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
