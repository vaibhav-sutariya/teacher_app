import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../models/history_model.dart';
import '../../../../models/staff_model.dart';

part 'attendance_history_event.dart';
part 'attendance_history_state.dart';

class StaffAttendanceHistoryBloc
    extends Bloc<StaffAttendanceHistoryEvent, StaffAttendanceHistoryState> {
  final StaffMember staff;

  StaffAttendanceHistoryBloc(this.staff)
    : super(
        StaffAttendanceHistoryState(
          status: StaffAttendanceHistoryStatus.initial,
          selectedMonth: DateTime.now(),
        ),
      ) {
    on<LoadAttendanceHistory>(_onLoadHistory);
    on<ChangeHistoryMonth>(_onChangeMonth);
  }

  Future<void> _onLoadHistory(
    LoadAttendanceHistory event,
    Emitter<StaffAttendanceHistoryState> emit,
  ) async {
    emit(state.copyWith(status: StaffAttendanceHistoryStatus.loading));
    try {
      // Mock API delay
      await Future.delayed(const Duration(milliseconds: 500));
      final logs = StaffAttendanceHistoryLog.getMockLogs(state.selectedMonth);

      emit(
        state.copyWith(status: StaffAttendanceHistoryStatus.loaded, logs: logs),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: StaffAttendanceHistoryStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onChangeMonth(
    ChangeHistoryMonth event,
    Emitter<StaffAttendanceHistoryState> emit,
  ) {
    emit(state.copyWith(selectedMonth: event.month));
    add(LoadAttendanceHistory());
  }
}
