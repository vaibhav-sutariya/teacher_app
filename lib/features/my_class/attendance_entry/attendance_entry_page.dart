import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../core/widgets/app_app_bar.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../cubit/theme_cubit.dart';
import 'bloc/attendance_entry_bloc.dart';
import 'bloc/attendance_entry_event.dart';
import 'bloc/attendance_entry_state.dart';
import 'models/student_attendance_model.dart';
import 'widgets/student_attendance_card.dart';

@RoutePage()
class AttendanceEntryPage extends StatelessWidget {
  final String className;
  final DateTime date;

  // Passing className and date from previous screen
  const AttendanceEntryPage({
    super.key,
    required this.className,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AttendanceEntryBloc()..add(LoadAttendanceEntry(className, date)),
      child: const _AttendanceEntryContent(),
    );
  }
}

class _AttendanceEntryContent extends StatelessWidget {
  const _AttendanceEntryContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceEntryBloc, AttendanceEntryState>(
      buildWhen: (previous, current) =>
          previous.isLoading != current.isLoading ||
          previous.className != current.className ||
          previous.date != current.date ||
          previous.sendSms != current.sendSms,
      builder: (context, state) {
        if (state.isLoading) {
          return Scaffold(
            appBar: const AppAppBar(title: 'Attendance Entry'),
            body: const Center(child: AppLoader()),
          );
        }

        final dateStr = DateFormat('dd-MMM-yyyy').format(state.date);

        return Scaffold(
          backgroundColor: context.colors.surface100,
          appBar: AppAppBar(
            title: 'Attendance Entry',
            actions: [
              IconButton(
                icon: Icon(Icons.edit, color: context.colors.primary),
                onPressed: () {},
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Row
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.scale(16),
                  vertical: context.scaleHeight(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      state.className, // e.g. "Jr.KG-JAL"
                      style: TextStyle(
                        fontSize: context.scaleFont(24),
                        fontWeight: FontWeight.w900,
                        color: context.colors.primary,
                      ),
                    ),
                    Text(
                      dateStr, // e.g. "25-Jun-2025"
                      style: TextStyle(
                        fontSize: context.scaleFont(14),
                        fontWeight: FontWeight.w600,
                        color: context.colors.textSecondary, // Slate Grey
                      ),
                    ),
                  ],
                ),
              ),

              // SMS Toggle Card
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.scale(16)),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.scale(16),
                    vertical: context.scaleHeight(12),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(context.scale(12)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SEND SMS',
                              style: TextStyle(
                                fontSize: context.scaleFont(14),
                                fontWeight: FontWeight.bold,
                                color: context.colors.iconDefault,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(height: context.scaleHeight(4)),
                            Text(
                              'Notify parents automatically',
                              style: TextStyle(
                                fontSize: context.scaleFont(12),
                                color: context.colors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: state.sendSms,
                        activeColor: Colors.white,
                        activeTrackColor: context.colors.primary,
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: Colors.grey.shade300,
                        onChanged: (value) {
                          context.read<AttendanceEntryBloc>().add(
                            ToggleSendSms(value),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: context.scaleHeight(24)),

              // List Headers
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.scale(24)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'STUDENT DETAILS',
                      style: TextStyle(
                        fontSize: context.scaleFont(12),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        color: context.colors.textSecondary.withValues(
                          alpha: 0.7,
                        ),
                      ),
                    ),
                    Text(
                      'STATUS',
                      style: TextStyle(
                        fontSize: context.scaleFont(12),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        color: context.colors.textSecondary.withValues(
                          alpha: 0.7,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: context.scaleHeight(8)),

              // Students List
              Expanded(
                child:
                    BlocSelector<
                      AttendanceEntryBloc,
                      AttendanceEntryState,
                      List<StudentAttendanceModel>
                    >(
                      selector: (state) => state.students,
                      builder: (context, students) {
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.only(
                            bottom: context.scaleHeight(24),
                          ),
                          cacheExtent: 500, // optimization for large lists
                          itemCount: students.length,
                          itemBuilder: (context, index) {
                            final student = students[index];
                            return RepaintBoundary(
                              child: StudentAttendanceCard(
                                student: student,
                                onStatusTap: () {
                                  final newStatus =
                                      student.status ==
                                          AttendanceStatusEnum.present
                                      ? AttendanceStatusEnum.absent
                                      : student.status ==
                                            AttendanceStatusEnum.absent
                                      ? AttendanceStatusEnum.notMarked
                                      : AttendanceStatusEnum.present;
                                  context.read<AttendanceEntryBloc>().add(
                                    MarkStudentStatus(
                                      student.studentId,
                                      newStatus,
                                    ),
                                  );
                                },
                                onSpecialStatusTap: () {
                                  // Could open a bottom sheet to select from list
                                  // For now just toggle between S and L
                                  final newSp = student.specialStatus == 'S'
                                      ? 'L'
                                      : 'S';
                                  context.read<AttendanceEntryBloc>().add(
                                    ChangeSpecialStatus(
                                      student.studentId,
                                      newSp,
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
              ),
            ],
          ),
        );
      },
    );
  }
}
