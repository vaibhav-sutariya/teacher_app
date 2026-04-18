import 'package:auto_route/auto_route.dart';
import 'package:teachers_app/core/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';
import 'package:teachers_app/core/widgets/app_primary_button.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import '../bloc/attendance_bloc.dart';
import '../../../../models/attendance_model.dart';
import 'widgets/attendance_summary_widgets.dart';

@RoutePage()
class StaffAttendancePage extends StatelessWidget {
  const StaffAttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          StaffAttendanceBloc()..add(LoadAttendanceSummary(DateTime.now())),
      child: const _AttendanceContent(),
    );
  }
}

class _AttendanceContent extends StatelessWidget {
  const _AttendanceContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface100,
      appBar: const AppAppBar(title: 'Staff Attendance'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: context.scaleHeight(20)),

            // Summary Card
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.scale(16)),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(context.scale(20)),
                margin: EdgeInsets.only(bottom: context.scaleHeight(20)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(context.scale(25)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      "Today's Attendance",
                      style: TextStyle(
                        fontSize: context.scaleFont(18),
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    SizedBox(height: context.scaleHeight(25)),

                    // Animated Date Circle
                    BlocSelector<
                      StaffAttendanceBloc,
                      StaffAttendanceState,
                      StaffAttendanceSummary?
                    >(
                      selector: (state) => state.summary,
                      builder: (context, summary) {
                        if (summary == null) {
                          return SizedBox(
                            height: context.scale(160),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        return AttendanceDateCircle(
                          date: summary.date,
                          percentage: summary.presentPercentage,
                        );
                      },
                    ),

                    SizedBox(height: context.scaleHeight(30)),

                    // Metrics List
                    BlocSelector<
                      StaffAttendanceBloc,
                      StaffAttendanceState,
                      StaffAttendanceSummary?
                    >(
                      selector: (state) => state.summary,
                      builder: (context, summary) {
                        if (summary == null) return const SizedBox.shrink();
                        return Column(
                          children: [
                            AttendanceMetricCard(
                              label: 'Present',
                              count: summary.presentCount,
                              color: Colors.green,
                              icon: Icons.check_circle_outline,
                            ),
                            SizedBox(height: context.scaleHeight(12)),
                            AttendanceMetricCard(
                              label: 'On Leave',
                              count: summary.onLeaveCount,
                              color: Colors.orange,
                              icon: Icons.timer_outlined,
                            ),
                            SizedBox(height: context.scaleHeight(12)),
                            AttendanceMetricCard(
                              label: 'Absent',
                              count: summary.absentCount,
                              color: Colors.red,
                              icon: Icons.error_outline_rounded,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Month Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.scale(16)),
              child: AppPrimaryButton(
                onPressed: () =>
                    context.router.push(const StaffAttendanceDetailsRoute()),
                text: 'Month Wise Details',
                color: context.colors.primary,
                textColor: Colors.white,
                borderRadius: context.scale(15),
              ),
            ),

            SizedBox(height: context.scaleHeight(40)),
          ],
        ),
      ),
    );
  }
}
