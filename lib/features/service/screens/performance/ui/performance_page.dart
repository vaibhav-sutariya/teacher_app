import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/widgets/month_calendar.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import 'package:teachers_app/features/school/screens/staff_details_screen/staff_attendance_history_screen/ui/widgets/history_widgets.dart';
import '../bloc/performance_bloc.dart';

@RoutePage()
class PerformancePage extends StatelessWidget {
  const PerformancePage({super.key});

  void _showSummaryBottomSheet(BuildContext context, PerformanceState state) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => HistorySummaryBottomSheet(
        present: state.totalPresent,
        absent: state.totalAbsent,
        leave: state.totalLeave,
        holiday: state.totalHoliday,
        weekOff: state.totalWeekOff,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PerformanceBloc()..add(LoadPerformanceHistory()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            // 1. Customized Header for Teacher
            BlocBuilder<PerformanceBloc, PerformanceState>(
              buildWhen: (previous, current) => previous.teacher != current.teacher,
              builder: (context, state) {
                return StaffHistoryHeader(staff: state.teacher);
              },
            ),

            // 2. Month Calendar Filter
            BlocBuilder<PerformanceBloc, PerformanceState>(
              buildWhen: (previous, current) => previous.selectedMonth != current.selectedMonth,
              builder: (context, state) {
                return MonthCalendar(
                  selectedMonth: state.selectedMonth,
                  onMonthChanged: (month) {
                    context.read<PerformanceBloc>().add(ChangePerformanceMonth(month));
                  },
                );
              },
            ),
            const Divider(height: 1),

            // 3. Daily Log List
            Expanded(
              child: BlocBuilder<PerformanceBloc, PerformanceState>(
                builder: (context, state) {
                  if (state.status == PerformanceStatus.loading) {
                    return Center(
                      child: CircularProgressIndicator(color: context.colors.primary),
                    );
                  }

                  if (state.status == PerformanceStatus.error) {
                    return Center(
                      child: Text(state.errorMessage ?? 'Failed to load logs'),
                    );
                  }

                  if (state.logs.isEmpty) {
                    return const Center(child: Text('No attendance logs found'));
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
            BlocBuilder<PerformanceBloc, PerformanceState>(
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
