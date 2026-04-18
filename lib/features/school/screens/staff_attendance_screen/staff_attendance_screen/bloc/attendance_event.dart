part of 'attendance_bloc.dart';

abstract class StaffAttendanceEvent extends Equatable {
  const StaffAttendanceEvent();

  @override
  List<Object?> get props => [];
}

class LoadAttendanceSummary extends StaffAttendanceEvent {
  final DateTime date;

  const LoadAttendanceSummary(this.date);

  @override
  List<Object?> get props => [date];
}

class ChangeAttendanceDate extends StaffAttendanceEvent {
  final DateTime date;

  const ChangeAttendanceDate(this.date);

  @override
  List<Object?> get props => [date];
}

class RefreshAttendanceData extends StaffAttendanceEvent {
  const RefreshAttendanceData();
}
