import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/exam_time_table_model.dart';
import '../../../repositories/exam_time_table_repository.dart';

part 'add_exam_time_table_state.dart';

class AddExamTimeTableBloc
    extends Bloc<AddExamTimeTableEvent, AddExamTimeTableState> {
  final ExamTimeTableRepository repository;

  AddExamTimeTableBloc({required this.repository})
    : super(AddExamTimeTableState.initial()) {
    on<UpdateExamTimeTableClassEvent>(
      (event, emit) => emit(state.copyWith(selectedClass: event.selectedClass)),
    );
    on<UpdateExamTimeTableNameEvent>(
      (event, emit) => emit(state.copyWith(examName: event.examName)),
    );
    on<UpdateExamTimeTablePdfUrlEvent>(
      (event, emit) => emit(state.copyWith(pdfUrl: event.pdfUrl)),
    );
    on<SubmitExamTimeTableEvent>(_onSubmitExamTimeTable);
  }

  Future<void> _onSubmitExamTimeTable(
    SubmitExamTimeTableEvent event,
    Emitter<AddExamTimeTableState> emit,
  ) async {
    if (state.selectedClass == null ||
        state.examName == null ||
        state.pdfUrl == null) {
      emit(state.copyWith(error: 'Required fields missing'));
      return;
    }

    emit(state.copyWith(isSubmitting: true, error: null));

    final timetable = ExamTimeTableModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      examName: state.examName!,
      className: state.selectedClass!,
      color: const Color(0xFF7E57C2), // Deep Purple
      pdfUrl: state.pdfUrl!,
    );

    final result = await repository.addExamTimeTable(timetable);

    result.fold(
      (failure) =>
          emit(state.copyWith(isSubmitting: false, error: failure.message)),
      (_) => emit(state.copyWith(isSubmitting: false, submitSuccess: true)),
    );
  }
}
