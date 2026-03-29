import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/attendance_model.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class StaffAttendanceBloc extends Bloc<StaffAttendanceEvent, StaffAttendanceState> {
  StaffAttendanceBloc()
      : super(StaffAttendanceState(
          status: StaffAttendanceStatus.initial,
          selectedDate: DateTime.now(),
        )) {
    on<LoadAttendanceSummary>(_onLoadAttendanceSummary);
    on<ChangeAttendanceDate>(_onChangeAttendanceDate);
    on<RefreshAttendanceData>(_onRefreshAttendanceData);
  }

  Future<void> _onLoadAttendanceSummary(
    LoadAttendanceSummary event,
    Emitter<StaffAttendanceState> emit,
  ) async {
    emit(state.copyWith(status: StaffAttendanceStatus.loading, selectedDate: event.date));
    try {
      // Mocking API call delay
      await Future.delayed(const Duration(milliseconds: 600));
      final summary = StaffAttendanceSummary.getMock(event.date);
      emit(state.copyWith(
        status: StaffAttendanceStatus.loaded,
        summary: summary,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: StaffAttendanceStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onChangeAttendanceDate(
    ChangeAttendanceDate event,
    Emitter<StaffAttendanceState> emit,
  ) async {
    // Small optimization: If the date is the same, do nothing.
    if (event.date.year == state.selectedDate.year &&
        event.date.month == state.selectedDate.month &&
        event.date.day == state.selectedDate.day) {
      return;
    }

    add(LoadAttendanceSummary(event.date));
  }

  Future<void> _onRefreshAttendanceData(
    RefreshAttendanceData event,
    Emitter<StaffAttendanceState> emit,
  ) async {
    if (state.status == StaffAttendanceStatus.loaded) {
      emit(state.copyWith(isRefreshing: true));
      try {
        await Future.delayed(const Duration(milliseconds: 800));
        final summary = StaffAttendanceSummary.getMock(state.selectedDate);
        emit(state.copyWith(
          summary: summary,
          isRefreshing: false,
        ));
      } catch (e) {
        emit(state.copyWith(isRefreshing: false));
      }
    }
  }
}
