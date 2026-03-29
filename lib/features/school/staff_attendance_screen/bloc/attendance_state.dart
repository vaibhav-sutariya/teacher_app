part of 'attendance_bloc.dart';

enum StaffAttendanceStatus { initial, loading, loaded, error }

class StaffAttendanceState extends Equatable {
  final StaffAttendanceStatus status;
  final StaffAttendanceSummary? summary;
  final DateTime selectedDate;
  final bool isRefreshing;
  final String? errorMessage;

  const StaffAttendanceState({
    required this.status,
    this.summary,
    required this.selectedDate,
    this.isRefreshing = false,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, summary, selectedDate, isRefreshing, errorMessage];

  StaffAttendanceState copyWith({
    StaffAttendanceStatus? status,
    StaffAttendanceSummary? summary,
    DateTime? selectedDate,
    bool? isRefreshing,
    String? errorMessage,
  }) {
    return StaffAttendanceState(
      status: status ?? this.status,
      summary: summary ?? this.summary,
      selectedDate: selectedDate ?? this.selectedDate,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
