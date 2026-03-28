import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/assignment_model.dart';
import '../repositories/assignment_repository.dart';

part 'add_assignment_event.dart';
part 'add_assignment_state.dart';

class AddAssignmentBloc extends Bloc<AddAssignmentEvent, AddAssignmentState> {
  final AssignmentRepository repository;

  AddAssignmentBloc({required this.repository}) : super(AddAssignmentState.initial()) {
    on<UpdateClassEvent>((event, emit) => emit(state.copyWith(selectedClass: event.selectedClass)));
    on<UpdateSectionEvent>((event, emit) => emit(state.copyWith(section: event.section)));
    on<UpdateSubjectEvent>((event, emit) => emit(state.copyWith(subject: event.subject)));
    on<UpdateLessonEvent>((event, emit) => emit(state.copyWith(lesson: event.lesson)));
    on<UpdateTopicEvent>((event, emit) => emit(state.copyWith(topic: event.topic)));
    on<UpdateAttachmentTypeEvent>((event, emit) => emit(state.copyWith(attachmentType: event.attachmentType)));
    on<UpdateDescriptionEvent>((event, emit) => emit(state.copyWith(description: event.description)));
    on<ToggleSmsEvent>((event, emit) => emit(state.copyWith(isSmsEnabled: event.isSmsEnabled)));
    on<SubmitAssignmentEvent>(_onSubmitAssignment);
  }

  Future<void> _onSubmitAssignment(
    SubmitAssignmentEvent event,
    Emitter<AddAssignmentState> emit,
  ) async {
    if (state.selectedClass == null || state.section == null) {
      emit(state.copyWith(error: 'Required fields missing'));
      return;
    }

    emit(state.copyWith(isSubmitting: true, error: null));
    
    final assignment = AssignmentModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      subject: state.subject ?? 'General',
      type: state.topic ?? 'New Assignment',
      // Primary color using Emerald Green for the app
      color: const Color(0xFF066046), 
      pdfUrl: 'https://online.op.ac.nz/assets/LearningAdvice/99ab78acca/Weekly-study-timetable.pdf',
      className: state.selectedClass,
      sectionName: state.section,
      lesson: state.lesson,
      topic: state.topic,
      description: state.description,
      attachmentType: state.attachmentType,
      isSmsEnabled: state.isSmsEnabled,
    );

    final result = await repository.addAssignment(assignment);
    
    result.fold(
      (failure) => emit(state.copyWith(isSubmitting: false, error: failure.message)),
      (_) => emit(state.copyWith(isSubmitting: false, submitSuccess: true)),
    );
  }
}
