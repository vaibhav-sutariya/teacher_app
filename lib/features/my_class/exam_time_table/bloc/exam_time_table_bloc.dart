import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/exam_time_table_model.dart';
import '../repositories/exam_time_table_repository.dart';

part 'exam_time_table_event.dart';
part 'exam_time_table_state.dart';

class ExamTimeTableBloc extends Bloc<ExamTimeTableEvent, ExamTimeTableState> {
  final ExamTimeTableRepository repository;

  ExamTimeTableBloc({required this.repository}) : super(ExamTimeTableInitial()) {
    on<LoadExamTimeTable>(_onLoadExamTimeTable);
  }

  Future<void> _onLoadExamTimeTable(
    LoadExamTimeTable event,
    Emitter<ExamTimeTableState> emit,
  ) async {
    emit(ExamTimeTableLoading());
    final result = await repository.getExamTimeTables();
    result.fold(
      (failure) => emit(ExamTimeTableError(failure.message)),
      (list) => emit(ExamTimeTableLoaded(list)),
    );
  }
}
