import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../models/time_table_model.dart';
import '../repositories/time_table_repository.dart';

part 'time_table_event.dart';
part 'time_table_state.dart';

@injectable
class TimeTableBloc extends Bloc<TimeTableEvent, TimeTableState> {
  final TimeTableRepository _repository;

  TimeTableBloc({required TimeTableRepository repository})
    : _repository = repository,
      super(TimeTableInitial()) {
    on<LoadTimeTables>(_onLoadTimeTables);
    on<AddTimeTable>(_onAddTimeTable);
  }

  Future<void> _onLoadTimeTables(
    LoadTimeTables event,
    Emitter<TimeTableState> emit,
  ) async {
    emit(TimeTableLoading());
    final result = await _repository.getTimeTables();

    result.fold(
      (failure) => emit(TimeTableError(failure.message)),
      (timetables) => emit(TimeTableLoaded(timetables)),
    );
  }

  Future<void> _onAddTimeTable(
    AddTimeTable event,
    Emitter<TimeTableState> emit,
  ) async {
    emit(TimeTableAdding());
    final result = await _repository.addTimeTable(event.timetable);

    result.fold(
      (failure) => emit(TimeTableError(failure.message)),
      (_) => emit(TimeTableAdded()),
    );
  }
}
