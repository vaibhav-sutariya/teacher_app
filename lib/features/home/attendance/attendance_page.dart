import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../core/widgets/app_app_bar.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../core/widgets/attendance_calendar.dart';
import '../../../core/widgets/error_state.dart';
import 'bloc/attendance_bloc.dart';
import 'bloc/attendance_event.dart';
import 'bloc/attendance_state.dart';
import 'widgets/attendance_summary.dart';
import 'widgets/selected_date_status_card.dart';

/// Production-ready attendance page
/// Optimized for performance with proper state management using BLoC
@RoutePage()
class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AttendanceBloc(),
      child: const _AttendancePageContent(),
    );
  }
}

class _AttendancePageContent extends StatelessWidget {
  const _AttendancePageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: const AppAppBar(title: 'Attendance'),
      body: BlocBuilder<AttendanceBloc, AttendanceState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () {
              context.read<AttendanceBloc>().add(
                const RefreshAttendanceEvent(),
              );
              return Future.value();
            },
            child: CustomScrollView(
              slivers: [
                // Calendar - Always visible
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: context.scaleHeight(16),
                      bottom: context.scaleHeight(16),
                    ),
                    child: AttendanceCalendar(
                      selectedDate: state.selectedDate,
                      attendanceData: state.calendarData,
                      academicYear:
                          state.attendanceData?.academicYear ??
                          'Loading...', // Show placeholder or data
                      onDateSelected: (date) {
                        context.read<AttendanceBloc>().add(
                          SelectDateEvent(date),
                        );
                      },
                      onMonthChanged: (month) {
                        context.read<AttendanceBloc>().add(
                          ChangeMonthEvent(month),
                        );
                      },
                    ),
                  ),
                ),

                // Content Loading State
                if (state.isLoading && state.attendanceData == null)
                  const SliverFillRemaining(child: Center(child: AppLoader()))
                else if (state.errorMessage != null &&
                    state.attendanceData == null)
                  SliverFillRemaining(
                    child: ErrorState(
                      message: state.errorMessage!,
                      onRetry: () => context.read<AttendanceBloc>().add(
                        const RefreshAttendanceEvent(),
                      ),
                    ),
                  )
                else if (state.attendanceData == null)
                  const SliverFillRemaining(
                    child: Center(child: Text('No data available')),
                  )
                else ...[
                  // Selected Date Status Card
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: context.scaleHeight(16)),
                      child: Builder(
                        builder: (_) {
                          final normalizedDate = DateTime(
                            state.selectedDate.year,
                            state.selectedDate.month,
                            state.selectedDate.day,
                          );
                          return SelectedDateStatusCard(
                            selectedDate: state.selectedDate,
                            status: state.calendarData[normalizedDate],
                          );
                        },
                      ),
                    ),
                  ),
                  // Monthly Summary
                  SliverToBoxAdapter(
                    child: AttendanceSummary(
                      title: 'Monthly Attendance Summary',
                      totalDays: state.attendanceData?.totalDays ?? 0,
                      presentDays: state.attendanceData?.presentDays ?? 0,
                      overallPercentage:
                          state.attendanceData?.overallPercentage ?? 0.0,
                    ),
                  ),
                  // Yearly Summary
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: context.scaleHeight(24)),
                      child: AttendanceSummary(
                        title: 'Yearly Attendance Summary',
                        totalDays: state.yearlyTotalDays ?? 0,
                        presentDays: state.yearlyPresentDays ?? 0,
                        overallPercentage: state.yearlyOverallPercentage ?? 0.0,
                      ),
                    ),
                  ),
                  // Bottom padding
                  SliverToBoxAdapter(
                    child: SizedBox(height: context.scaleHeight(20)),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
