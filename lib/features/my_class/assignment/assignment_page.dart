import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection.dart';
import '../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../core/routes/app_router.gr.dart';
import '../../../core/widgets/app_app_bar.dart';
import '../../../core/widgets/app_loader.dart';
import 'bloc/assignment_bloc.dart';
import 'ui/widgets/assignment_card.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

@RoutePage()
class AssignmentPage extends StatelessWidget implements AutoRouteWrapper {
  const AssignmentPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => AssignmentBloc(repository: sl.get())..add(FetchAssignments()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface100,
      appBar: const AppAppBar(title: 'Assignment', showBackButton: true),
      body: BlocBuilder<AssignmentBloc, AssignmentState>(
        buildWhen: (previous, current) =>
            current is AssignmentLoading ||
            current is AssignmentLoadedState ||
            current is AssignmentError,
        builder: (context, state) {
          if (state is AssignmentLoading) {
            return const Center(child: AppLoader());
          } else if (state is AssignmentLoadedState) {
            if (state.assignmentList.isEmpty) {
              return _buildEmptyState(context);
            }

            return ListView.builder(
              padding: EdgeInsets.all(context.scale(16)),
              itemCount: state.assignmentList.length,
              itemBuilder: (context, index) {
                final assignment = state.assignmentList[index];
                return AssignmentCard(assignment: assignment);
              },
            );
          } else if (state is AssignmentError) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(context.scale(24)),
                child: Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: context.colors.error),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await context.router.push(const AddAssignmentRoute());
          if (context.mounted) {
            context.read<AssignmentBloc>().add(FetchAssignments());
          }
        },
        backgroundColor: context.colors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.assignment_outlined,
            size: context.scale(64),
            color: Colors.grey.withValues(alpha: 0.5),
          ),
          SizedBox(height: context.scaleHeight(16)),
          Text(
            'No Assignments Available',
            style: TextStyle(
              fontSize: context.scaleFont(16),
              color: context.colors.textTertiary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
