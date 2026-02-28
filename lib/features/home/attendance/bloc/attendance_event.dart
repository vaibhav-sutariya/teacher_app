import 'package:equatable/equatable.dart';

/// Base class for all attendance events
abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load attendance data
class LoadAttendanceEvent extends AttendanceEvent {
  const LoadAttendanceEvent();
}

/// Event to refresh attendance data
class RefreshAttendanceEvent extends AttendanceEvent {
  const RefreshAttendanceEvent();
}

/// Event to select a date in the calendar
class SelectDateEvent extends AttendanceEvent {
  final DateTime date;

  const SelectDateEvent(this.date);

  @override
  List<Object?> get props => [date];
}

/// Event to change the current month
class ChangeMonthEvent extends AttendanceEvent {
  final DateTime month;

  const ChangeMonthEvent(this.month);

  @override
  List<Object?> get props => [month];
}

/// Event to load attendance for a specific month
class LoadAttendanceForMonthEvent extends AttendanceEvent {
  final DateTime month;

  const LoadAttendanceForMonthEvent(this.month);

  @override
  List<Object?> get props => [month];
}
