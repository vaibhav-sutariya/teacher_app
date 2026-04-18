import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../../core/widgets/app_app_bar.dart';
import '../../../../../../core/widgets/app_primary_button.dart';
import '../../../../../../cubit/theme_cubit.dart';
import '../bloc/transport_attendance_bloc.dart';
import '../../models/transport_student_model.dart';
import 'widgets/transport_attendance_card.dart';

@RoutePage()
class TransportAttendancePage extends StatelessWidget {
  const TransportAttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransportAttendanceBloc(),
      child: BlocListener<TransportAttendanceBloc, TransportAttendanceState>(
        listenWhen: (previous, current) =>
            previous.submitSuccess != current.submitSuccess ||
            previous.error != current.error,
        listener: (context, state) {
          if (state.submitSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Transport attendance submitted successfully'),
              ),
            );
            context.router.back();
          } else if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: const _TransportAttendanceContent(),
      ),
    );
  }
}

class _TransportAttendanceContent extends StatelessWidget {
  const _TransportAttendanceContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransportAttendanceBloc, TransportAttendanceState>(
      buildWhen: (previous, current) =>
          previous.isLoading != current.isLoading ||
          previous.selectedRoute != current.selectedRoute ||
          previous.date != current.date ||
          previous.isSubmitting != current.isSubmitting,
      builder: (context, state) {
        final dateStr = DateFormat('dd-MMM-yyyy').format(state.date);

        return Scaffold(
          backgroundColor: context.colors.surface100,
          appBar: const AppAppBar(title: 'Transport Attendance'),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header parameters selection
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(context.scale(16)),
                child: Column(
                  children: [
                    // Route Selection Dropdown
                    DropdownButtonFormField<String>(
                      value: state.selectedRoute,
                      hint: const Text('Select Route'),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: context.scale(16),
                          vertical: context.scaleHeight(12),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: context.colors.surface100,
                      ),
                      items: ['Route 1', 'Route 2', 'Route 3'].map((r) {
                        return DropdownMenuItem(value: r, child: Text(r));
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          context.read<TransportAttendanceBloc>().add(
                            SelectRouteEvent(val),
                          );
                        }
                      },
                    ),
                    SizedBox(height: context.scaleHeight(16)),
                    // Date picker Row
                    InkWell(
                      onTap: () async {
                        final dt = await showDatePicker(
                          context: context,
                          initialDate: state.date,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100),
                        );
                        if (dt != null) {
                          if (context.mounted) {
                            context.read<TransportAttendanceBloc>().add(
                              SelectDateEvent(dt),
                            );
                          }
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.scale(16),
                          vertical: context.scaleHeight(14),
                        ),
                        decoration: BoxDecoration(
                          color: context.colors.surface100,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              dateStr,
                              style: TextStyle(fontSize: context.scaleFont(16)),
                            ),
                            Icon(
                              Icons.calendar_today,
                              color: context.colors.primary,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: context.scaleHeight(8)),

              if (state.isLoading)
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (state.selectedRoute == null)
                Expanded(
                  child: Center(
                    child: Text(
                      'Please select a route to load students.',
                      style: TextStyle(color: context.colors.textSecondary),
                    ),
                  ),
                )
              else
                Expanded(
                  child: Column(
                    children: [
                      // List Headers
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.scale(24),
                          vertical: context.scaleHeight(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'STUDENTS',
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

                      // Students List
                      Expanded(
                        child:
                            BlocSelector<
                              TransportAttendanceBloc,
                              TransportAttendanceState,
                              List<TransportStudentModel>
                            >(
                              selector: (state) => state.filteredStudents,
                              builder: (context, students) {
                                if (students.isEmpty) {
                                  return const Center(
                                    child: Text("No students found."),
                                  );
                                }
                                return ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  padding: EdgeInsets.only(
                                    bottom: context.scaleHeight(80),
                                  ),
                                  itemCount: students.length,
                                  itemBuilder: (context, index) {
                                    final student = students[index];
                                    return TransportAttendanceCard(
                                      student: student,
                                      onStatusTap: () {
                                        final newStatus =
                                            student.status ==
                                                TransportAttendanceStatus
                                                    .boarded
                                            ? TransportAttendanceStatus
                                                  .notBoarded
                                            : student.status ==
                                                  TransportAttendanceStatus
                                                      .notBoarded
                                            ? TransportAttendanceStatus
                                                  .notMarked
                                            : TransportAttendanceStatus.boarded;
                                        context
                                            .read<TransportAttendanceBloc>()
                                            .add(
                                              ToggleAttendanceStatusEvent(
                                                student.id,
                                                newStatus,
                                              ),
                                            );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          bottomNavigationBar: (state.selectedRoute != null && !state.isLoading)
              ? Padding(
                  padding: EdgeInsets.all(context.scale(16)),
                  child: AppPrimaryButton(
                    onPressed: () {
                      context.read<TransportAttendanceBloc>().add(
                        SubmitAttendanceEvent(),
                      );
                    },
                    text: 'SUBMIT ATTENDANCE',
                    isLoading: state.isSubmitting,
                  ),
                )
              : null,
        );
      },
    );
  }
}
