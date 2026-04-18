import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../models/punch_models.dart';

part 'punch_tracker_event.dart';
part 'punch_tracker_state.dart';

class PunchTrackerBloc extends Bloc<PunchTrackerEvent, PunchTrackerState> {
  PunchTrackerBloc() : super(PunchTrackerInitial()) {
    on<LoadPunchData>(_onLoadPunchData);
    on<ChangePunchTab>(_onChangePunchTab);
    on<ChangePunchMonth>(_onChangePunchMonth);
  }

  void _onLoadPunchData(
      LoadPunchData event, Emitter<PunchTrackerState> emit) {
    emit(PunchTrackerLoading());
    try {
      final records = PunchRecord.getMockData(event.month);
      emit(PunchTrackerLoaded(
        records: records,
        selectedMonth: event.month,
      ));
    } catch (e) {
      emit(PunchTrackerError(e.toString()));
    }
  }

  void _onChangePunchTab(
      ChangePunchTab event, Emitter<PunchTrackerState> emit) {
    if (state is PunchTrackerLoaded) {
      final currentState = state as PunchTrackerLoaded;
      emit(PunchTrackerLoaded(
        records: currentState.records,
        selectedMonth: currentState.selectedMonth,
        selectedTabIndex: event.index,
      ));
    }
  }

  void _onChangePunchMonth(
      ChangePunchMonth event, Emitter<PunchTrackerState> emit) {
    add(LoadPunchData(event.month));
  }
}
