part of 'attendance_details_bloc.dart';

enum StaffAttendanceDetailsStatus { initial, loading, loaded, error }

class StaffAttendanceDetailsState extends Equatable {
  final StaffAttendanceDetailsStatus status;
  final DateTime selectedMonth;
  final List<StaffAttendanceSummary> dailyRecords;
  final String? errorMessage;

  const StaffAttendanceDetailsState({
    required this.status,
    required this.selectedMonth,
    this.dailyRecords = const [],
    this.errorMessage,
  });

  StaffAttendanceDetailsState copyWith({
    StaffAttendanceDetailsStatus? status,
    DateTime? selectedMonth,
    List<StaffAttendanceSummary>? dailyRecords,
    String? errorMessage,
  }) {
    return StaffAttendanceDetailsState(
      status: status ?? this.status,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      dailyRecords: dailyRecords ?? this.dailyRecords,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, selectedMonth, dailyRecords, errorMessage];
}
