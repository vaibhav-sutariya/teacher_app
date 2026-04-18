part of 'attendance_details_bloc.dart';

abstract class StaffAttendanceDetailsEvent extends Equatable {
  const StaffAttendanceDetailsEvent();

  @override
  List<Object?> get props => [];
}

class LoadMonthDetails extends StaffAttendanceDetailsEvent {
  final DateTime month;
  const LoadMonthDetails(this.month);

  @override
  List<Object?> get props => [month];
}

class ChangeDetailsMonth extends StaffAttendanceDetailsEvent {
  final DateTime month;
  const ChangeDetailsMonth(this.month);

  @override
  List<Object?> get props => [month];
}
