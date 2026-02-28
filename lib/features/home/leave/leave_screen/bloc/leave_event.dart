part of 'leave_bloc.dart';

abstract class LeaveEvent extends Equatable {
  const LeaveEvent();

  @override
  List<Object?> get props => [];
}

class LoadLeaveData extends LeaveEvent {}

class ChangeTabEvent extends LeaveEvent {
  final int tabIndex;

  const ChangeTabEvent(this.tabIndex);

  @override
  List<Object?> get props => [tabIndex];
}

class MonthChanged extends LeaveEvent {
  final DateTime month;

  const MonthChanged(this.month);

  @override
  List<Object?> get props => [month];
}

class RefreshLeaveData extends LeaveEvent {}
