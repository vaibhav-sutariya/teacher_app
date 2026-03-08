import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'subject_wise_homework_event.dart';
import 'subject_wise_homework_state.dart';

class SubjectWiseHomeworkBloc
    extends Bloc<SubjectWiseHomeworkEvent, SubjectWiseHomeworkState> {
  final List<String> _allClasses = [
    'LITTLE CHAMPS - JAL',
    'LITTLE CHAMPS - VAYU',
    'LITTLE CHAMPS - AAKASH',
    'LITTLE CHAMPS - PRITHVI',
    'LITTLE CHAMPS - TEJ',
    'JR.KG - JAL',
    'JR.KG - VAYU',
    'JR.KG - AAKASH',
    'JR.KG - PRITHVI',
    'SR.KG - JAL',
    'SR.KG - VAYU',
    'SR.KG - AAKASH',
    'SR.KG - PRITHVI',
  ];

  SubjectWiseHomeworkBloc() : super(SubjectWiseHomeworkInitial()) {
    on<SubjectWiseHomeworkLoaded>(_onLoaded);
    on<SubjectWiseHomeworkDateChanged>(_onDateChanged);
  }

  Future<void> _onLoaded(
    SubjectWiseHomeworkLoaded event,
    Emitter<SubjectWiseHomeworkState> emit,
  ) async {
    emit(SubjectWiseHomeworkLoading());
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Default to today
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    emit(
      SubjectWiseHomeworkLoadedState(classes: _allClasses, selectedDate: today),
    );
  }

  void _onDateChanged(
    SubjectWiseHomeworkDateChanged event,
    Emitter<SubjectWiseHomeworkState> emit,
  ) {
    if (state is SubjectWiseHomeworkLoadedState) {
      final currentState = state as SubjectWiseHomeworkLoadedState;
      // Avoid rebuilding if same date is selected
      if (DateUtils.isSameDay(currentState.selectedDate, event.date)) {
        return;
      }

      emit(currentState.copyWith(selectedDate: event.date));
    }
  }
}
