import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/attendance_calendar.dart';
import '../models/attendance_model.dart';
import '../repositories/attendance_repository.dart';
import 'attendance_event.dart';
import 'attendance_state.dart';

/// Production-ready attendance bloc
/// Ready for API integration - currently uses mock data
class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AttendanceRepository? _attendanceRepository;

  AttendanceBloc({AttendanceRepository? attendanceRepository})
    : _attendanceRepository = attendanceRepository,
      super(AttendanceState.initial()) {
    // Register event handlers
    on<LoadAttendanceEvent>(_onLoadAttendance);
    on<RefreshAttendanceEvent>(_onRefreshAttendance);
    on<SelectDateEvent>(_onSelectDate);
    on<ChangeMonthEvent>(_onChangeMonth);
    on<LoadAttendanceForMonthEvent>(_onLoadAttendanceForMonth);

    // Load initial data
    add(const LoadAttendanceEvent());
  }

  /// Handle load attendance event
  Future<void> _onLoadAttendance(
    LoadAttendanceEvent event,
    Emitter<AttendanceState> emit,
  ) async {
    // Keep existing data, just set loading
    emit(state.copyWith(isLoading: true, clearError: true));

    try {
      // TODO: Replace with actual API call when repository is implemented
      // if (_attendanceRepository != null) {
      //   final result = await _attendanceRepository!.getAttendance(
      //     studentId: 'current_student_id', // Get from preferences or context
      //   );
      //   return result.fold(
      //     (failure) => emit(state.copyWith(
      //       isLoading: false,
      //       errorMessage: failure.message,
      //     )),
      //     (data) {
      //       final calendarData = data.getCalendarData();
      //       emit(state.copyWith(
      //         isLoading: false,
      //         attendanceData: data,
      //         calendarData: calendarData,
      //       ));
      //     },
      //   );
      // }

      // Mock data for UI development
      await Future.delayed(const Duration(milliseconds: 500));
      final mockData = _getMockAttendanceData();
      final calendarData = mockData.getCalendarData();

      // Calculate summary from actual calendar data
      final calculatedData = _calculateSummaryFromCalendarData(
        calendarData,
        mockData,
      );

      // Calculate yearly summary
      final yearlySummary = _calculateYearlySummary(calendarData);

      emit(
        state.copyWith(
          isLoading: false,
          attendanceData: calculatedData,
          calendarData: calendarData,
          yearlyTotalDays: yearlySummary['totalDays'] as int,
          yearlyPresentDays: yearlySummary['presentDays'] as int,
          yearlyOverallPercentage: yearlySummary['overallPercentage'] as double,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to load attendance data',
        ),
      );
    }
  }

  /// Handle refresh attendance event
  Future<void> _onRefreshAttendance(
    RefreshAttendanceEvent event,
    Emitter<AttendanceState> emit,
  ) async {
    await _onLoadAttendance(const LoadAttendanceEvent(), emit);
  }

  /// Handle select date event
  void _onSelectDate(SelectDateEvent event, Emitter<AttendanceState> emit) {
    emit(state.copyWith(selectedDate: event.date));
  }

  /// Handle change month event
  void _onChangeMonth(ChangeMonthEvent event, Emitter<AttendanceState> emit) {
    emit(state.copyWith(currentMonth: event.month));
    // Optionally load data for the new month
    add(LoadAttendanceForMonthEvent(event.month));
  }

  /// Handle load attendance for specific month event
  Future<void> _onLoadAttendanceForMonth(
    LoadAttendanceForMonthEvent event,
    Emitter<AttendanceState> emit,
  ) async {
    // TODO: Implement when API is ready
    // emit(state.copyWith(isLoading: true));
    // final result = await _attendanceRepository!.getAttendance(
    //   studentId: 'current_student_id',
    //   month: event.month,
    //   year: event.month.year,
    // );
    // result.fold(
    //   (failure) => emit(state.copyWith(
    //     isLoading: false,
    //     errorMessage: failure.message,
    //   )),
    //   (data) {
    //     final calendarData = data.getCalendarData();
    //     emit(state.copyWith(
    //       isLoading: false,
    //       attendanceData: data,
    //       calendarData: calendarData,
    //     ));
    //   },
    // );
  }

  /// Mock data for UI development - remove when API is ready
  AttendanceModel _getMockAttendanceData() {
    final now = DateTime.now();
    final currentYear = now.year;
    final currentMonth = DateTime(now.year, now.month);
    final today = now.day;

    // Generate mock attendance data for the entire year up to today
    final attendanceData = <String, String>{};
    final startOfYear = DateTime(currentYear, 1, 1);
    final todayDate = DateTime(currentYear, now.month, now.day);

    // Generate data for all months from January to current month
    DateTime currentDate = startOfYear;
    while (currentDate.isBefore(todayDate) ||
        currentDate.isAtSameMomentAs(todayDate)) {
      final dateString = currentDate.toIso8601String().split('T')[0];
      final weekday = currentDate.weekday; // 1 = Monday, 7 = Sunday

      // Mark Sundays as holidays
      if (weekday == 7) {
        attendanceData[dateString] = 'HOLIDAY';
      } else {
        // For mock data, mark some days as absent (e.g., 5th of each month)
        // and rest as present
        if (currentDate.day == 5) {
          attendanceData[dateString] = 'ABSENT';
        } else {
          attendanceData[dateString] = 'PRESENT';
        }
      }

      // Move to next day
      currentDate = currentDate.add(const Duration(days: 1));
    }

    // Note: Summary will be calculated from calendar data in _calculateSummaryFromCalendarData
    return AttendanceModel(
      studentId: '12345',
      studentName: 'Alexander Wright',
      academicYear: 'ACADEMIC YEAR 23/24',
      className: 'Sophomore • Computer Science',
      totalDays: null, // Will be calculated from calendar data
      presentDays: null, // Will be calculated from calendar data
      absentDays: null, // Will be calculated from calendar data
      overallPercentage: null, // Will be calculated from calendar data
      attendanceData: attendanceData,
      feedbackMessage:
          'Your attendance is 5% higher than the class average this month.',
      classAverage: 86.0,
    );
  }

  /// Calculate attendance summary from calendar data
  /// This ensures accurate calculation including all Sundays as holidays
  AttendanceModel _calculateSummaryFromCalendarData(
    Map<DateTime, AttendanceStatus> calendarData,
    AttendanceModel baseModel,
  ) {
    final now = DateTime.now();
    final currentMonth = DateTime(now.year, now.month);
    final today = now.day;
    // Get the last day of the current month
    final lastDayOfMonth = DateTime(
      currentMonth.year,
      currentMonth.month + 1,
      0,
    ).day;

    int presentCount = 0;
    int absentCount = 0;
    int holidayCount = 0;

    // Count all days up to today, including Sundays as holidays
    for (int day = 1; day <= today; day++) {
      final date = DateTime(currentMonth.year, currentMonth.month, day);
      final normalizedDate = DateTime(date.year, date.month, date.day);
      final weekday = date.weekday; // 1 = Monday, 7 = Sunday

      // All Sundays are holidays
      if (weekday == 7) {
        holidayCount++;
      } else {
        // Get status from calendar data
        final status =
            calendarData[normalizedDate] ?? AttendanceStatus.notMarked;
        switch (status) {
          case AttendanceStatus.present:
            presentCount++;
            break;
          case AttendanceStatus.absent:
            absentCount++;
            break;
          case AttendanceStatus.holiday:
            holidayCount++;
            break;
          case AttendanceStatus.notMarked:
            // Not marked days are not counted in summary
            break;
        }
      }
    }

    // Count all Sundays in the entire month to exclude from working days
    int totalSundaysInMonth = 0;
    for (int day = 1; day <= lastDayOfMonth; day++) {
      final date = DateTime(currentMonth.year, currentMonth.month, day);
      if (date.weekday == 7) {
        totalSundaysInMonth++;
      }
    }

    // Total days = all working days in the month (excluding Sundays)
    final totalDays = lastDayOfMonth - totalSundaysInMonth;

    // Overall percentage = (Present Days / Working Days up to today) * 100
    // Note: Using working days up to today for percentage calculation (excluding Sundays)
    final workingDaysUpToToday = presentCount + absentCount;
    final overallPercentage = workingDaysUpToToday > 0
        ? ((presentCount / workingDaysUpToToday) * 100).roundToDouble()
        : 0.0;

    return baseModel.copyWith(
      totalDays: totalDays,
      presentDays: presentCount,
      absentDays: absentCount,
      overallPercentage: overallPercentage,
    );
  }

  /// Calculate yearly attendance summary from calendar data
  /// This calculates attendance for the entire current year up to today
  Map<String, dynamic> _calculateYearlySummary(
    Map<DateTime, AttendanceStatus> calendarData,
  ) {
    final now = DateTime.now();
    final currentYear = now.year;
    final today = now;

    int presentCount = 0;
    int absentCount = 0;
    int holidayCount = 0;

    // Count all days from January 1st to today in the current year
    final startOfYear = DateTime(currentYear, 1, 1);
    final endOfYear = today;

    DateTime currentDate = startOfYear;
    while (currentDate.isBefore(endOfYear) ||
        currentDate.isAtSameMomentAs(endOfYear)) {
      final normalizedDate = DateTime(
        currentDate.year,
        currentDate.month,
        currentDate.day,
      );
      final weekday = currentDate.weekday; // 1 = Monday, 7 = Sunday

      // All Sundays are holidays
      if (weekday == 7) {
        holidayCount++;
      } else {
        // Get status from calendar data
        final status =
            calendarData[normalizedDate] ?? AttendanceStatus.notMarked;
        switch (status) {
          case AttendanceStatus.present:
            presentCount++;
            break;
          case AttendanceStatus.absent:
            absentCount++;
            break;
          case AttendanceStatus.holiday:
            holidayCount++;
            break;
          case AttendanceStatus.notMarked:
            // Not marked days are not counted in summary
            break;
        }
      }

      // Move to next day
      currentDate = currentDate.add(const Duration(days: 1));
    }

    // Count all Sundays in the entire year to exclude from working days
    int totalSundaysInYear = 0;
    final lastDayOfYear = DateTime(currentYear, 12, 31);
    DateTime checkDate = startOfYear;
    while (checkDate.isBefore(lastDayOfYear) ||
        checkDate.isAtSameMomentAs(lastDayOfYear)) {
      if (checkDate.weekday == 7) {
        totalSundaysInYear++;
      }
      checkDate = checkDate.add(const Duration(days: 1));
    }

    // Total days = all working days in the year (excluding Sundays)
    // For the year, we count all days from Jan 1 to Dec 31
    final isLeapYear =
        currentYear % 4 == 0 &&
        (currentYear % 100 != 0 || currentYear % 400 == 0);
    final actualTotalDaysInYear = isLeapYear ? 366 : 365;
    final totalDays = actualTotalDaysInYear - totalSundaysInYear;

    // Overall percentage = (Present Days / Working Days up to today) * 100
    // Note: Using working days up to today for percentage calculation (excluding Sundays)
    final workingDaysUpToToday = presentCount + absentCount;
    final overallPercentage = workingDaysUpToToday > 0
        ? ((presentCount / workingDaysUpToToday) * 100).roundToDouble()
        : 0.0;

    return {
      'totalDays': totalDays,
      'presentDays': presentCount,
      'overallPercentage': overallPercentage,
    };
  }
}
