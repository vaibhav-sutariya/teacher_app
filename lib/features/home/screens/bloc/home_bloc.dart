import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/dashboard_models.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<LoadDashboardData>(_onLoadDashboardData);
  }

  void _onLoadDashboardData(
    LoadDashboardData event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));

      final todayEvents = [
        const EventModel(
          id: '1',
          title: 'Staff Meeting',
          time: '10:00 AM - 11:30 AM',
          location: 'Conference Room A',
        ),
        const EventModel(
          id: '2',
          title: 'Parent-Teacher Conference',
          time: '02:00 PM - 04:00 PM',
          location: 'Room 204',
        ),
      ];

      final pendingLeaves = [
        const LeaveModel(
          id: '1',
          studentName: 'SHETH ANSHI HEMAL',
          gradeSection: '5TH-VAYU',
          leaveType: 'OL',
        ),
        const LeaveModel(
          id: '2',
          studentName: 'JOSHI DURVA RASHMIKANT',
          gradeSection: '9TH-VAYU',
          leaveType: 'OL',
        ),
        const LeaveModel(
          id: '3',
          studentName: 'DAVE DWIJA VISHAL',
          gradeSection: '3RD-VAYU',
          leaveType: 'SF',
        ),
      ];

      final birthdays = [
        BirthdayModel(
          id: '1',
          studentName: 'KHATRI HARSHIL RAJULKUMAR',
          gradeSection: 'Class: 11th-COMMERCE-JAL',
          date: DateTime(DateTime.now().year, 6, 25),
        ),
      ];

      final homeworkStats = HomeworkStatsModel(
        updatedSections: 0,
        totalSections: 52,
        date: DateTime.now(),
      );

      const attendanceStats = AttendanceStatsModel(
        markedSections: 52,
        totalSections: 52,
        totalStudents: 2427,
        markedStudents: '-',
        present: 0,
        absent: 0,
        leave: 0,
        percentage: 0,
      );

      final announcements = [
        AnnouncementModel(
          id: '1',
          title: 'School Annual Function Dates Announced',
          content:
              'The Annual Function will be held on the 24th to 26th of next month. All teachers are requested to report to the auditorium. Please prepare your students accordingly and ensure all permissions are gathered.',
          date: DateTime.now(),
        ),
      ];

      emit(
        state.copyWith(
          status: HomeStatus.loaded,
          todayEvents: todayEvents,
          announcements: announcements,
          pendingLeaves: pendingLeaves,
          birthdays: birthdays,
          homeworkStats: homeworkStats,
          attendanceStats: attendanceStats,
          isCheckedIn: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeStatus.error,
          errorMessage: 'Failed to load dashboard data',
        ),
      );
    }
  }
}
