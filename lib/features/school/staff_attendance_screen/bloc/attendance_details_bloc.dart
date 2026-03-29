import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/attendance_model.dart';

part 'attendance_details_event.dart';
part 'attendance_details_state.dart';

class StaffAttendanceDetailsBloc
    extends Bloc<StaffAttendanceDetailsEvent, StaffAttendanceDetailsState> {
  StaffAttendanceDetailsBloc()
      : super(StaffAttendanceDetailsState(
          status: StaffAttendanceDetailsStatus.initial,
          selectedMonth: DateTime.now(),
        )) {
    on<LoadMonthDetails>(_onLoadMonthDetails);
    on<ChangeDetailsMonth>(_onChangeDetailsMonth);
  }

  Future<void> _onLoadMonthDetails(
    LoadMonthDetails event,
    Emitter<StaffAttendanceDetailsState> emit,
  ) async {
    emit(state.copyWith(
      status: StaffAttendanceDetailsStatus.loading,
      selectedMonth: event.month,
    ));

    try {
      // Mocking API delay
      await Future.delayed(const Duration(milliseconds: 600));

      final records = StaffAttendanceSummary.getMonthlyMock(event.month);

      emit(state.copyWith(
        status: StaffAttendanceDetailsStatus.loaded,
        dailyRecords: records,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: StaffAttendanceDetailsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onChangeDetailsMonth(
    ChangeDetailsMonth event,
    Emitter<StaffAttendanceDetailsState> emit,
  ) async {
    // Avoid redundant loads for same month/year
    if (event.month.month == state.selectedMonth.month &&
        event.month.year == state.selectedMonth.year) {
      return;
    }
    add(LoadMonthDetails(event.month));
  }
}
