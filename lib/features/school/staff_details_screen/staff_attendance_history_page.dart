import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/widgets/month_calendar.dart';

import '../../../core/widgets/app_app_bar.dart';
import 'bloc/attendance_history_bloc.dart';
import 'models/staff_model.dart';
import 'widgets/history_widgets.dart';

@RoutePage()
class StaffAttendanceHistoryPage extends StatelessWidget {
  final StaffMember staff;

  const StaffAttendanceHistoryPage({super.key, required this.staff});

  void _showSummaryBottomSheet(
    BuildContext context,
    StaffAttendanceHistoryState state,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => HistorySummaryBottomSheet(
        present: state.presentCount,
        absent: state.absentCount,
        leave: state.leaveCount,
        holiday: state.holidayCount,
        weekOff: state.weekOffCount,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          StaffAttendanceHistoryBloc(staff)..add(LoadAttendanceHistory()),
      child: Scaffold(
        backgroundColor: Colors.white,

        body: Column(
          children: [
            // 1. Custom Yellow Header
            StaffHistoryHeader(staff: staff),

            // 2. Month Calendar Filter
            BlocBuilder<
              StaffAttendanceHistoryBloc,
              StaffAttendanceHistoryState
            >(
              buildWhen: (previous, current) =>
                  previous.selectedMonth != current.selectedMonth,
              builder: (context, state) {
                return MonthCalendar(
                  selectedMonth: state.selectedMonth,
                  onMonthChanged: (month) {
                    context.read<StaffAttendanceHistoryBloc>().add(
                      ChangeHistoryMonth(month),
                    );
                  },
                );
              },
            ),

            // 3. Daily Log List
            Expanded(
              child:
                  BlocBuilder<
                    StaffAttendanceHistoryBloc,
                    StaffAttendanceHistoryState
                  >(
                    builder: (context, state) {
                      if (state.status ==
                          StaffAttendanceHistoryStatus.loading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state.status == StaffAttendanceHistoryStatus.error) {
                        return Center(
                          child: Text(
                            state.errorMessage ?? 'Failed to load logs',
                          ),
                        );
                      }

                      if (state.logs.isEmpty) {
                        return const Center(
                          child: Text('No attendance logs found'),
                        );
                      }

                      return ListView.builder(
                        itemCount: state.logs.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return AttendanceHistoryTile(log: state.logs[index]);
                        },
                      );
                    },
                  ),
            ),

            // 4. Summary Footer
            BlocBuilder<
              StaffAttendanceHistoryBloc,
              StaffAttendanceHistoryState
            >(
              builder: (context, state) {
                return AttendanceSummaryFooter(
                  onTap: () => _showSummaryBottomSheet(context, state),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
