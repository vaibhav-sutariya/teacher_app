import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/leave_models.dart';

part 'leave_tracker_event.dart';
part 'leave_tracker_state.dart';

class LeaveTrackerBloc extends Bloc<LeaveTrackerEvent, LeaveTrackerState> {
  LeaveTrackerBloc() : super(LeaveTrackerInitial()) {
    on<LoadLeaveTracker>(_onLoadLeaveTracker);
    on<ChangeYearRange>(_onChangeYearRange);
    on<ChangeTab>(_onChangeTab);
  }

  Future<void> _onLoadLeaveTracker(
    LoadLeaveTracker event,
    Emitter<LeaveTrackerState> emit,
  ) async {
    emit(LeaveTrackerLoading());
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      final now = DateTime.now();
      final startDate = DateTime(now.year, 6, 1);
      final endDate = DateTime(now.year + 1, 5, 31);
      
      emit(LeaveTrackerLoaded(
        leaves: LeaveApplication.getMockLeaves(),
        holidays: HolidayModel.getMockHolidays(),
        balances: LeaveBalanceModel.getMockBalances(),
        startDate: startDate,
        endDate: endDate,
        selectedTabIndex: 0,
      ));
    } catch (e) {
      emit(LeaveTrackerError(message: e.toString()));
    }
  }

  void _onChangeYearRange(
    ChangeYearRange event,
    Emitter<LeaveTrackerState> emit,
  ) {
    if (state is LeaveTrackerLoaded) {
      final currentState = state as LeaveTrackerLoaded;
      final newStartDate = DateTime(
        currentState.startDate.year + (event.isNext ? 1 : -1),
        currentState.startDate.month,
        currentState.startDate.day,
      );
      final newEndDate = DateTime(
        currentState.endDate.year + (event.isNext ? 1 : -1),
        currentState.endDate.month,
        currentState.endDate.day,
      );
      
      emit(currentState.copyWith(
        startDate: newStartDate,
        endDate: newEndDate,
      ));
    }
  }

  void _onChangeTab(
    ChangeTab event,
    Emitter<LeaveTrackerState> emit,
  ) {
    if (state is LeaveTrackerLoaded) {
      emit((state as LeaveTrackerLoaded).copyWith(selectedTabIndex: event.index));
    }
  }
}
