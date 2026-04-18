import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';
import 'package:teachers_app/core/widgets/month_calendar.dart';

import '../bloc/attendance_details_bloc.dart';
import '../../staff_attendance_screen/ui/widgets/attendance_detail_tile.dart';

@RoutePage()
class StaffAttendanceDetailsPage extends StatelessWidget {
  const StaffAttendanceDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          StaffAttendanceDetailsBloc()..add(LoadMonthDetails(DateTime.now())),
      child: const _DetailsContent(),
    );
  }
}

class _DetailsContent extends StatelessWidget {
  const _DetailsContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppAppBar(title: 'Staff Attendance'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.orange.shade400,
        elevation: 4,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.person_search_rounded,
          color: Colors.white,
          size: 28,
        ),
      ),
      body: Column(
        children: [
          // 1. Month Calendar Navigation
          BlocSelector<
            StaffAttendanceDetailsBloc,
            StaffAttendanceDetailsState,
            DateTime
          >(
            selector: (state) => state.selectedMonth,
            builder: (context, selectedMonth) {
              return MonthCalendar(
                selectedMonth: selectedMonth,
                onMonthChanged: (newMonth) {
                  context.read<StaffAttendanceDetailsBloc>().add(
                    ChangeDetailsMonth(newMonth),
                  );
                },
              );
            },
          ),

          // 2. Attendance List
          Expanded(
            child:
                BlocBuilder<
                  StaffAttendanceDetailsBloc,
                  StaffAttendanceDetailsState
                >(
                  builder: (context, state) {
                    if (state.status == StaffAttendanceDetailsStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.status == StaffAttendanceDetailsStatus.error) {
                      return Center(
                        child: Text(
                          state.errorMessage ?? 'Failed to load data',
                        ),
                      );
                    }

                    if (state.dailyRecords.isEmpty) {
                      return const Center(
                        child: Text('No records found for this month'),
                      );
                    }

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: state.dailyRecords.length,
                      itemBuilder: (context, index) {
                        return AttendanceDetailTile(
                          summary: state.dailyRecords[index],
                        );
                      },
                    );
                  },
                ),
          ),
        ],
      ),
    );
  }
}
