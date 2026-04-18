import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teachers_app/features/service/models/leave_models.dart';

part 'leave_tracker_event.dart';
part 'leave_tracker_state.dart';

class LeaveTrackerBloc extends Bloc<LeaveTrackerEvent, LeaveTrackerState> {
  LeaveTrackerBloc() : super(LeaveTrackerInitial()) {
    on<LoadLeaveTracker>(_onLoadLeaveTracker);
    on<ChangeTab>(_onChangeTab);
    on<ChangeYearRange>(_onChangeYearRange);
  }

  void _onLoadLeaveTracker(
      LoadLeaveTracker event, Emitter<LeaveTrackerState> emit) {
    emit(LeaveTrackerLoading());
    try {
      final now = DateTime.now();
      final startDate = DateTime(now.year, 1, 1);
      final endDate = DateTime(now.year, 12, 31);
      
      final leaves = LeaveApplication.getMockLeaves();
      final holidays = HolidayModel.getMockHolidays();
      final balances = LeaveBalanceModel.getMockBalances();
      
      emit(LeaveTrackerLoaded(
        leaves: leaves,
        holidays: holidays,
        balances: balances,
        startDate: startDate,
        endDate: endDate,
      ));
    } catch (e) {
      emit(LeaveTrackerError(e.toString()));
    }
  }

  void _onChangeTab(ChangeTab event, Emitter<LeaveTrackerState> emit) {
    if (state is LeaveTrackerLoaded) {
      final currentState = state as LeaveTrackerLoaded;
      emit(LeaveTrackerLoaded(
        leaves: currentState.leaves,
        holidays: currentState.holidays,
        balances: currentState.balances,
        startDate: currentState.startDate,
        endDate: currentState.endDate,
        selectedTabIndex: event.index,
      ));
    }
  }

  void _onChangeYearRange(ChangeYearRange event, Emitter<LeaveTrackerState> emit) {
    if (state is LeaveTrackerLoaded) {
      final currentState = state as LeaveTrackerLoaded;
      final newStartDate = DateTime(
        currentState.startDate.year + (event.isNext ? 1 : -1),
        1,
        1,
      );
      final newEndDate = DateTime(
        currentState.endDate.year + (event.isNext ? 1 : -1),
        12,
        31,
      );
      
      emit(LeaveTrackerLoaded(
        leaves: currentState.leaves, // In real app, we would reload data here
        holidays: currentState.holidays,
        balances: currentState.balances,
        startDate: newStartDate,
        endDate: newEndDate,
        selectedTabIndex: currentState.selectedTabIndex,
      ));
    }
  }
}
