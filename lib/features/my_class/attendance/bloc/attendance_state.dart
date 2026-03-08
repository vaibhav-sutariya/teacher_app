import 'package:equatable/equatable.dart';

import '../../../../core/widgets/attendance_calendar.dart';
import '../models/attendance_model.dart';
import '../models/class_section_model.dart';

/// Production-ready attendance state with proper equality
class AttendanceState extends Equatable {
  final bool isLoading;
  final AttendanceModel? attendanceData;
  final DateTime selectedDate;
  final DateTime currentMonth;
  final String? errorMessage;
  final Map<DateTime, AttendanceStatus> calendarData;

  // New fields for redefined Attendance UI
  final int selectedTabIndex;
  final List<ClassSectionModel> pendingClasses;
  final List<ClassSectionModel> markedClasses;

  // Yearly summary fields
  final int? yearlyTotalDays;
  final int? yearlyPresentDays;
  final double? yearlyOverallPercentage;

  const AttendanceState({
    this.isLoading = false,
    this.attendanceData,
    required this.selectedDate,
    required this.currentMonth,
    this.errorMessage,
    this.calendarData = const {},
    this.selectedTabIndex = 0,
    this.pendingClasses = const [],
    this.markedClasses = const [],
    this.yearlyTotalDays,
    this.yearlyPresentDays,
    this.yearlyOverallPercentage,
  });

  /// Factory constructor for initial state with current date defaults
  factory AttendanceState.initial({
    DateTime? selectedDate,
    DateTime? currentMonth,
  }) {
    return AttendanceState(
      selectedDate: selectedDate ?? DateTime.now(),
      currentMonth: currentMonth ?? DateTime.now(),
    );
  }

  AttendanceState copyWith({
    bool? isLoading,
    AttendanceModel? attendanceData,
    DateTime? selectedDate,
    DateTime? currentMonth,
    String? errorMessage,
    Map<DateTime, AttendanceStatus>? calendarData,
    int? selectedTabIndex,
    List<ClassSectionModel>? pendingClasses,
    List<ClassSectionModel>? markedClasses,
    int? yearlyTotalDays,
    int? yearlyPresentDays,
    double? yearlyOverallPercentage,
    bool clearError = false,
  }) {
    return AttendanceState(
      isLoading: isLoading ?? this.isLoading,
      attendanceData: attendanceData ?? this.attendanceData,
      selectedDate: selectedDate ?? this.selectedDate,
      currentMonth: currentMonth ?? this.currentMonth,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      calendarData: calendarData ?? this.calendarData,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      pendingClasses: pendingClasses ?? this.pendingClasses,
      markedClasses: markedClasses ?? this.markedClasses,
      yearlyTotalDays: yearlyTotalDays ?? this.yearlyTotalDays,
      yearlyPresentDays: yearlyPresentDays ?? this.yearlyPresentDays,
      yearlyOverallPercentage:
          yearlyOverallPercentage ?? this.yearlyOverallPercentage,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    attendanceData,
    selectedDate,
    currentMonth,
    errorMessage,
    calendarData,
    selectedTabIndex,
    pendingClasses,
    markedClasses,
    yearlyTotalDays,
    yearlyPresentDays,
    yearlyOverallPercentage,
  ];
}
