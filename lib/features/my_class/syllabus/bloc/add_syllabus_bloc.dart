import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/syllabus_model.dart';
import '../repositories/syllabus_repository.dart';

part 'add_syllabus_state.dart';

class AddSyllabusBloc extends Bloc<AddSyllabusEvent, AddSyllabusState> {
  final SyllabusRepository repository;

  AddSyllabusBloc({required this.repository}) : super(AddSyllabusState.initial()) {
    on<UpdateSyllabusClassEvent>((event, emit) => emit(state.copyWith(selectedClass: event.selectedClass)));
    on<UpdateSyllabusSectionEvent>((event, emit) => emit(state.copyWith(section: event.section)));
    on<UpdateSyllabusSubjectEvent>((event, emit) => emit(state.copyWith(subject: event.subject)));
    on<UpdateSyllabusTypeEvent>((event, emit) => emit(state.copyWith(type: event.type)));
    on<UpdateSyllabusPdfUrlEvent>((event, emit) => emit(state.copyWith(pdfUrl: event.pdfUrl)));
    on<SubmitSyllabusEvent>(_onSubmitSyllabus);
  }

  Future<void> _onSubmitSyllabus(
    SubmitSyllabusEvent event,
    Emitter<AddSyllabusState> emit,
  ) async {
    if (state.selectedClass == null || state.section == null || state.pdfUrl == null) {
      emit(state.copyWith(error: 'Required fields missing'));
      return;
    }

    emit(state.copyWith(isSubmitting: true, error: null));
    
    final syllabus = SyllabusModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      subject: state.subject ?? 'General',
      type: state.type ?? 'New Syllabus',
      color: const Color(0xFF066046), // Emerald Green
      pdfUrl: state.pdfUrl!,
    );

    final result = await repository.addSyllabus(syllabus);
    
    result.fold(
      (failure) => emit(state.copyWith(isSubmitting: false, error: failure.message)),
      (_) => emit(state.copyWith(isSubmitting: false, submitSuccess: true)),
    );
  }
}
