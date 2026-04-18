import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/holiday_hw_model.dart';
import '../../../repositories/holiday_hw_repository.dart';

part 'holiday_hw_event.dart';
part 'holiday_hw_state.dart';

class HolidayHwBloc extends Bloc<HolidayHwEvent, HolidayHwState> {
  final HolidayHwRepository repository;

  HolidayHwBloc({required this.repository}) : super(HolidayHwLoading()) {
    on<LoadHolidayHw>(_onLoadHolidayHw);
  }

  Future<void> _onLoadHolidayHw(
    LoadHolidayHw event,
    Emitter<HolidayHwState> emit,
  ) async {
    emit(HolidayHwLoading());
    final result = await repository.getHolidayHw();
    result.fold(
      (failure) => emit(HolidayHwError(failure.message)),
      (hwList) => emit(HolidayHwLoadedState(hwList)),
    );
  }
}
