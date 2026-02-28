part of 'leave_bloc.dart';

abstract class LeaveState extends Equatable {
  const LeaveState();

  @override
  List<Object?> get props => [];
}

class LeaveInitial extends LeaveState {}

class LeaveLoading extends LeaveState {}

class LeaveLoadedState extends LeaveState {
  final List<LeaveModel> leaveList;
  final List<HolidayModel> holidayList;
  final int selectedTabIndex;
  final DateTime selectedMonth;
  final bool isLoading;

  const LeaveLoadedState({
    required this.leaveList,
    required this.holidayList,
    required this.selectedTabIndex,
    required this.selectedMonth,
    this.isLoading = false,
  });

  LeaveLoadedState copyWith({
    List<LeaveModel>? leaveList,
    List<HolidayModel>? holidayList,
    int? selectedTabIndex,
    DateTime? selectedMonth,
    bool? isLoading,
  }) {
    return LeaveLoadedState(
      leaveList: leaveList ?? this.leaveList,
      holidayList: holidayList ?? this.holidayList,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
    leaveList,
    holidayList,
    selectedTabIndex,
    selectedMonth,
    isLoading,
  ];
}

class LeaveError extends LeaveState {
  final String message;

  const LeaveError(this.message);

  @override
  List<Object?> get props => [message];
}
