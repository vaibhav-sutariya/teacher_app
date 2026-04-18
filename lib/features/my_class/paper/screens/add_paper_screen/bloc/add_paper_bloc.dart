import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/paper_model.dart';
import '../../../repositories/paper_repository.dart';

part 'add_paper_state.dart';

class AddPaperBloc extends Bloc<AddPaperEvent, AddPaperState> {
  final PaperRepository repository;

  AddPaperBloc({required this.repository}) : super(AddPaperState.initial()) {
    on<UpdatePaperClassEvent>(
      (event, emit) => emit(state.copyWith(selectedClass: event.selectedClass)),
    );
    on<UpdatePaperSectionEvent>(
      (event, emit) => emit(state.copyWith(section: event.section)),
    );
    on<UpdatePaperSubjectEvent>(
      (event, emit) => emit(state.copyWith(subject: event.subject)),
    );
    on<UpdatePaperNameEvent>(
      (event, emit) => emit(state.copyWith(paperName: event.paperName)),
    );
    on<UpdatePaperPdfUrlEvent>(
      (event, emit) => emit(state.copyWith(pdfUrl: event.pdfUrl)),
    );
    on<SubmitPaperEvent>(_onSubmitPaper);
  }

  Future<void> _onSubmitPaper(
    SubmitPaperEvent event,
    Emitter<AddPaperState> emit,
  ) async {
    if (state.selectedClass == null ||
        state.section == null ||
        state.pdfUrl == null) {
      emit(state.copyWith(error: 'Required fields missing'));
      return;
    }

    emit(state.copyWith(isSubmitting: true, error: null));

    final paper = PaperModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      subject: state.subject ?? 'General',
      type: state.paperName ?? 'Exam Paper',
      color: const Color(0xFF5C6BC0), // Indigo
      pdfUrl: state.pdfUrl!,
    );

    final result = await repository.addPaper(paper);

    result.fold(
      (failure) =>
          emit(state.copyWith(isSubmitting: false, error: failure.message)),
      (_) => emit(state.copyWith(isSubmitting: false, submitSuccess: true)),
    );
  }
}
