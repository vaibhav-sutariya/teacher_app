import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import 'package:teachers_app/core/widgets/app_app_bar.dart';
import 'package:teachers_app/core/widgets/app_tab_bar.dart';
import 'package:teachers_app/core/widgets/empty_state_view.dart';
import '../../models/student_leave_model.dart';
import 'bloc/student_leave_bloc.dart';

@RoutePage()
class StudentLeavePage extends StatelessWidget {
  const StudentLeavePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentLeaveBloc()..add(LoadStudentLeaves()),
      child: Scaffold(
        backgroundColor: context.colors.surface100,
        appBar: const AppAppBar(title: 'Student Leave'),
        body: Column(
          children: [
            // Safe spacing
            // Custom TabBar wrapped with BlocSelector for optimized rebuilds
            BlocSelector<StudentLeaveBloc, StudentLeaveState, int>(
              selector: (state) {
                if (state is StudentLeaveLoaded) {
                  return state.selectedTabIndex;
                }
                return 0; // Default pending tab
              },
              builder: (context, selectedIndex) {
                return AppTabBar(
                  tabs: const ['PENDING', 'APPROVED', 'REJECTED'],
                  selectedIndex: selectedIndex,
                  onTabChanged: (index) {
                    context.read<StudentLeaveBloc>().add(
                      ChangeStudentLeaveTab(index),
                    );
                  },
                );
              },
            ),

            // Tab Content Output
            Expanded(
              child: BlocBuilder<StudentLeaveBloc, StudentLeaveState>(
                builder: (context, state) {
                  if (state is StudentLeaveLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: context.colors.primary,
                      ),
                    );
                  }

                  if (state is StudentLeaveError) {
                    return Center(child: Text(state.message));
                  }

                  if (state is StudentLeaveLoaded) {
                    final List<StudentLeaveModel> currentList;
                    switch (state.selectedTabIndex) {
                      case 0:
                        currentList = state.pendingList;
                        break;
                      case 1:
                        currentList = state.approvedList;
                        break;
                      case 2:
                        currentList = state.rejectedList;
                        break;
                      default:
                        currentList = [];
                    }

                    if (currentList.isEmpty) {
                      return const EmptyStateView();
                    }

                    return ListView.builder(
                      padding: EdgeInsets.all(context.scale(16)),
                      itemCount: currentList.length,
                      itemBuilder: (context, index) {
                        return _StudentLeaveCard(leave: currentList[index]);
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StudentLeaveCard extends StatelessWidget {
  final StudentLeaveModel leave;

  const _StudentLeaveCard({required this.leave});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.scaleHeight(12)),
      padding: EdgeInsets.symmetric(
        horizontal: context.scale(12),
        vertical: context.scaleHeight(16),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.scale(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile Picture with Orange/Gold border
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.orange.shade300, width: 2),
            ),
            child: CircleAvatar(
              radius: context.scale(25),
              backgroundImage: NetworkImage(leave.imageUrl),
              backgroundColor: Colors.grey.shade200,
            ),
          ),

          SizedBox(width: context.scale(16)),

          // Info Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  leave.title,
                  style: TextStyle(
                    fontSize: context.scaleFont(15),
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: context.scaleHeight(4)),
                Text(
                  'Requested on ${leave.requestDate}',
                  style: TextStyle(
                    fontSize: context.scaleFont(12),
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: context.scale(12)),

          // Class Badge (Pill)
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.scale(12),
              vertical: context.scaleHeight(6),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.blue.shade400, width: 1),
              borderRadius: BorderRadius.circular(context.scale(20)),
            ),
            child: Text(
              leave.className,
              style: TextStyle(
                fontSize: context.scaleFont(11),
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
