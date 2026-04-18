part of 'punch_tracker_bloc.dart';

abstract class PunchTrackerState extends Equatable {
  const PunchTrackerState();

  @override
  List<Object?> get props => [];
}

class PunchTrackerInitial extends PunchTrackerState {}

class PunchTrackerLoading extends PunchTrackerState {}

class PunchTrackerLoaded extends PunchTrackerState {
  final List<PunchRecord> records;
  final DateTime selectedMonth;
  final int selectedTabIndex;

  const PunchTrackerLoaded({
    required this.records,
    required this.selectedMonth,
    this.selectedTabIndex = 0,
  });

  @override
  List<Object?> get props => [records, selectedMonth, selectedTabIndex];
}

class PunchTrackerError extends PunchTrackerState {
  final String message;
  const PunchTrackerError(this.message);

  @override
  List<Object?> get props => [message];
}
