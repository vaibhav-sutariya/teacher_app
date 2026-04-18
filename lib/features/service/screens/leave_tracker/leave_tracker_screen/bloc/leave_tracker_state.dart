part of 'leave_tracker_bloc.dart';

abstract class LeaveTrackerState extends Equatable {
  const LeaveTrackerState();

  @override
  List<Object?> get props => [];
}

class LeaveTrackerInitial extends LeaveTrackerState {}

class LeaveTrackerLoading extends LeaveTrackerState {}

class LeaveTrackerLoaded extends LeaveTrackerState {
  final List<LeaveApplication> leaves;
  final List<HolidayModel> holidays;
  final List<LeaveBalanceModel> balances;
  final DateTime startDate;
  final DateTime endDate;
  final int selectedTabIndex;

  const LeaveTrackerLoaded({
    required this.leaves,
    required this.holidays,
    required this.balances,
    required this.startDate,
    required this.endDate,
    this.selectedTabIndex = 0,
  });

  @override
  List<Object?> get props => [
        leaves,
        holidays,
        balances,
        startDate,
        endDate,
        selectedTabIndex,
      ];
}

class LeaveTrackerError extends LeaveTrackerState {
  final String message;
  const LeaveTrackerError(this.message);

  @override
  List<Object?> get props => [message];
}
