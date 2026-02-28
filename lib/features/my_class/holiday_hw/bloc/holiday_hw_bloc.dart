import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/holiday_hw_model.dart';

part 'holiday_hw_event.dart';
part 'holiday_hw_state.dart';

class HolidayHwBloc extends Bloc<HolidayHwEvent, HolidayHwState> {
  HolidayHwBloc() : super(HolidayHwLoading()) {
    on<HolidayHwLoaded>(_onHolidayHwLoaded);
  }

  Future<void> _onHolidayHwLoaded(
    HolidayHwLoaded event,
    Emitter<HolidayHwState> emit,
  ) async {
    emit(HolidayHwLoading());

    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Load mock data
      final holidayHwList = HolidayHwModel.getMockData();

      emit(HolidayHwLoadedState(holidayHwList));
    } catch (e) {
      emit(HolidayHwError('Failed to load holiday homework: ${e.toString()}'));
    }
  }
}
