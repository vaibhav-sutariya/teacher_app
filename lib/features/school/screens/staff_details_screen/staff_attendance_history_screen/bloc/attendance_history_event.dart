part of 'attendance_history_bloc.dart';

abstract class StaffAttendanceHistoryEvent extends Equatable {
  const StaffAttendanceHistoryEvent();

  @override
  List<Object?> get props => [];
}

class LoadAttendanceHistory extends StaffAttendanceHistoryEvent {}

class ChangeHistoryMonth extends StaffAttendanceHistoryEvent {
  final DateTime month;
  const ChangeHistoryMonth(this.month);

  @override
  List<Object?> get props => [month];
}
