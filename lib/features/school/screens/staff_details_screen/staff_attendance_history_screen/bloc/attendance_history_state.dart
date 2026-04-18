part of 'attendance_history_bloc.dart';

enum StaffAttendanceHistoryStatus { initial, loading, loaded, error }

class StaffAttendanceHistoryState extends Equatable {
  final StaffAttendanceHistoryStatus status;
  final DateTime selectedMonth;
  final List<StaffAttendanceHistoryLog> logs;
  final String? errorMessage;

  const StaffAttendanceHistoryState({
    required this.status,
    required this.selectedMonth,
    this.logs = const [],
    this.errorMessage,
  });

  int get presentCount => logs.where((l) => l.status == StaffHistoryStatus.present).length;
  int get absentCount => logs.where((l) => l.status == StaffHistoryStatus.absent).length;
  int get weekOffCount => logs.where((l) => l.status == StaffHistoryStatus.weekOff).length;
  int get leaveCount => logs.where((l) => l.status == StaffHistoryStatus.leave).length;
  int get holidayCount => logs.where((l) => l.status == StaffHistoryStatus.holiday).length;

  StaffAttendanceHistoryState copyWith({
    StaffAttendanceHistoryStatus? status,
    DateTime? selectedMonth,
    List<StaffAttendanceHistoryLog>? logs,
    String? errorMessage,
  }) {
    return StaffAttendanceHistoryState(
      status: status ?? this.status,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      logs: logs ?? this.logs,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, selectedMonth, logs, errorMessage];
}
