import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/syllabus_model.dart';

part 'syllabus_event.dart';
part 'syllabus_state.dart';

class SyllabusBloc extends Bloc<SyllabusEvent, SyllabusState> {
  SyllabusBloc() : super(SyllabusLoading()) {
    on<SyllabusLoaded>(_onSyllabusLoaded);
  }

  Future<void> _onSyllabusLoaded(
    SyllabusLoaded event,
    Emitter<SyllabusState> emit,
  ) async {
    emit(SyllabusLoading());

    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Load mock data
      final syllabusList = SyllabusModel.getMockData();

      emit(SyllabusLoadedState(syllabusList));
    } catch (e) {
      emit(SyllabusError('Failed to load syllabus: ${e.toString()}'));
    }
  }
}
