import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../core/routes/app_router.gr.dart';
import '../../../../../core/widgets/app_loader.dart';
import '../../../../../core/widgets/end_of_list_indicator.dart';
import '../bloc/leave_bloc.dart';
import '../models/leave_model.dart';

/// VIEW tab content - displays leave applications and status
class ViewTab extends StatelessWidget {
  const ViewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LeaveBloc, LeaveState, LeaveState>(
      selector: (state) => state,
      builder: (context, state) {
        if (state is LeaveLoading) {
          return const AppLoader();
        } else if (state is LeaveLoadedState) {
          if (state.isLoading) {
            return const AppLoader();
          }
          if (state.leaveList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.event_busy_outlined,
                    size: context.scale(64),
                    color: Colors.grey.withValues(alpha: 0.5),
                  ),
                  SizedBox(height: context.scaleHeight(16)),
                  Text(
                    'No Leave Applications',
                    style: TextStyle(
                      fontSize: context.scaleFont(16),
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(context.scale(16)),
            itemCount: state.leaveList.length + 1,
            itemBuilder: (context, index) {
              if (index == state.leaveList.length) {
                return const EndOfListIndicator();
              }
              return Padding(
                padding: EdgeInsets.only(bottom: context.scaleHeight(12)),
                child: _buildLeaveApplicationCard(
                  context,
                  leave: state.leaveList[index],
                ),
              );
            },
          );
        } else if (state is LeaveError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildLeaveApplicationCard(
    BuildContext context, {
    required LeaveModel leave,
  }) {
    return GestureDetector(
      onTap: () {
        // Navigate to leave detail page
        context.router.push(LeaveDetailRoute(leaveId: leave.id));
      },
      child: Container(
        padding: EdgeInsets.all(context.scale(16)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(context.scale(12)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    leave.dateRange,
                    style: TextStyle(
                      fontSize: context.scaleFont(14),
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.scale(12),
                    vertical: context.scaleHeight(4),
                  ),
                  decoration: BoxDecoration(
                    color: Color(leave.statusColor).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(context.scale(12)),
                  ),
                  child: Text(
                    leave.statusText,
                    style: TextStyle(
                      fontSize: context.scaleFont(12),
                      fontWeight: FontWeight.w600,
                      color: Color(leave.statusColor),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: context.scaleHeight(8)),
            Text(
              'Reason: ${leave.reason}',
              style: TextStyle(
                fontSize: context.scaleFont(13),
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
