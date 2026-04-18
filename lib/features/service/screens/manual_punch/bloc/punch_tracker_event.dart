part of 'punch_tracker_bloc.dart';

abstract class PunchTrackerEvent extends Equatable {
  const PunchTrackerEvent();

  @override
  List<Object?> get props => [];
}

class LoadPunchData extends PunchTrackerEvent {
  final DateTime month;
  const LoadPunchData(this.month);

  @override
  List<Object?> get props => [month];
}

class ChangePunchTab extends PunchTrackerEvent {
  final int index;
  const ChangePunchTab(this.index);

  @override
  List<Object?> get props => [index];
}

class ChangePunchMonth extends PunchTrackerEvent {
  final DateTime month;
  const ChangePunchMonth(this.month);

  @override
  List<Object?> get props => [month];
}
