import 'package:flutter_bloc/flutter_bloc.dart';
import 'classwork_entry_event.dart';
import 'classwork_entry_state.dart';

class ClassworkEntryBloc
    extends Bloc<ClassworkEntryEvent, ClassworkEntryState> {
  ClassworkEntryBloc() : super(const ClassworkEntryState()) {
    on<ClassworkContentChanged>(_onContentChanged);
    on<SubmitClassworkEvent>(_onSubmit);
  }

  void _onContentChanged(
    ClassworkContentChanged event,
    Emitter<ClassworkEntryState> emit,
  ) {
    emit(state.copyWith(content: event.content));
  }

  Future<void> _onSubmit(
    SubmitClassworkEvent event,
    Emitter<ClassworkEntryState> emit,
  ) async {
    if (state.content.trim().isEmpty) {
      emit(state.copyWith(error: 'Please enter classwork content'));
      return;
    }

    emit(state.copyWith(isSubmitting: true, error: null));

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    emit(state.copyWith(isSubmitting: false, isSuccess: true));
  }
}
