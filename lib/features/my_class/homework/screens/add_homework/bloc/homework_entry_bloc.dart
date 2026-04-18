import 'package:flutter_bloc/flutter_bloc.dart';
import 'homework_entry_event.dart';
import 'homework_entry_state.dart';

class HomeworkEntryBloc extends Bloc<HomeworkEntryEvent, HomeworkEntryState> {
  HomeworkEntryBloc() : super(const HomeworkEntryState()) {
    on<HomeworkEntryContentChanged>(_onContentChanged);
    on<HomeworkEntryImageAdded>(_onImageAdded);
    on<HomeworkEntryDocumentAdded>(_onDocumentAdded);
    on<HomeworkEntrySubmitted>(_onSubmitted);
  }

  void _onContentChanged(
    HomeworkEntryContentChanged event,
    Emitter<HomeworkEntryState> emit,
  ) {
    emit(state.copyWith(content: event.content));
  }

  void _onImageAdded(
    HomeworkEntryImageAdded event,
    Emitter<HomeworkEntryState> emit,
  ) {
    final updatedImages = List<String>.from(state.images)..add(event.path);
    emit(state.copyWith(images: updatedImages));
  }

  void _onDocumentAdded(
    HomeworkEntryDocumentAdded event,
    Emitter<HomeworkEntryState> emit,
  ) {
    final updatedDocs = List<String>.from(state.documents)..add(event.path);
    emit(state.copyWith(documents: updatedDocs));
  }

  Future<void> _onSubmitted(
    HomeworkEntrySubmitted event,
    Emitter<HomeworkEntryState> emit,
  ) async {
    if (state.content.isEmpty) {
      emit(state.copyWith(error: 'Homework content cannot be empty'));
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
