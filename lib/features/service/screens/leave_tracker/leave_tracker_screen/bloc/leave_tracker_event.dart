part of 'leave_tracker_bloc.dart';

abstract class LeaveTrackerEvent extends Equatable {
  const LeaveTrackerEvent();

  @override
  List<Object?> get props => [];
}

class LoadLeaveTracker extends LeaveTrackerEvent {}

class ChangeTab extends LeaveTrackerEvent {
  final int index;
  const ChangeTab({required this.index});

  @override
  List<Object?> get props => [index];
}

class ChangeYearRange extends LeaveTrackerEvent {
  final bool isNext;
  const ChangeYearRange({required this.isNext});

  @override
  List<Object?> get props => [isNext];
}
