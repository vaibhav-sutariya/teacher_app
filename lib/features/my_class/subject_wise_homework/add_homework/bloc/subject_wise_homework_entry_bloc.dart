import 'package:flutter_bloc/flutter_bloc.dart';
import 'subject_wise_homework_entry_event.dart';
import 'subject_wise_homework_entry_state.dart';

class SubjectWiseHomeworkEntryBloc
    extends Bloc<SubjectWiseHomeworkEntryEvent, SubjectWiseHomeworkEntryState> {
  SubjectWiseHomeworkEntryBloc()
    : super(const SubjectWiseHomeworkEntryState()) {
    on<HomeworkContentChanged>(_onContentChanged);
    on<SubmissionDateChanged>(_onSubmissionDateChanged);
    on<ImageAttachmentAdded>(_onImageAdded);
    on<DocumentAttachmentAdded>(_onDocumentAdded);
    on<SubmitHomeworkEvent>(_onSubmitted);
  }

  void _onContentChanged(
    HomeworkContentChanged event,
    Emitter<SubjectWiseHomeworkEntryState> emit,
  ) {
    emit(state.copyWith(content: event.content));
  }

  void _onSubmissionDateChanged(
    SubmissionDateChanged event,
    Emitter<SubjectWiseHomeworkEntryState> emit,
  ) {
    emit(state.copyWith(submissionDate: event.date));
  }

  void _onImageAdded(
    ImageAttachmentAdded event,
    Emitter<SubjectWiseHomeworkEntryState> emit,
  ) {
    final updatedImages = List<String>.from(state.images)..add(event.path);
    emit(state.copyWith(images: updatedImages));
  }

  void _onDocumentAdded(
    DocumentAttachmentAdded event,
    Emitter<SubjectWiseHomeworkEntryState> emit,
  ) {
    final updatedDocs = List<String>.from(state.documents)..add(event.path);
    emit(state.copyWith(documents: updatedDocs));
  }

  Future<void> _onSubmitted(
    SubmitHomeworkEvent event,
    Emitter<SubjectWiseHomeworkEntryState> emit,
  ) async {
    if (state.content.isEmpty) {
      emit(state.copyWith(error: 'Homework content cannot be empty'));
      return;
    }
    if (state.submissionDate == null) {
      emit(state.copyWith(error: 'Please select a submission date'));
      return;
    }

    emit(state.copyWith(isSubmitting: true, error: null));

    try {
      // TODO: Implement actual API call
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, error: e.toString()));
    }
  }
}
