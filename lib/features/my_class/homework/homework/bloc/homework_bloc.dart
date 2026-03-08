import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'homework_event.dart';
import 'homework_state.dart';

class HomeworkBloc extends Bloc<HomeworkEvent, HomeworkState> {
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

  HomeworkBloc() : super(HomeworkInitial()) {
    on<HomeworkLoaded>(_onLoaded);
    on<HomeworkDateChanged>(_onDateChanged);
  }

  Future<void> _onLoaded(
    HomeworkLoaded event,
    Emitter<HomeworkState> emit,
  ) async {
    emit(HomeworkLoading());
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Default to today
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    emit(HomeworkLoadedState(classes: _allClasses, selectedDate: today));
  }

  void _onDateChanged(HomeworkDateChanged event, Emitter<HomeworkState> emit) {
    if (state is HomeworkLoadedState) {
      final currentState = state as HomeworkLoadedState;
      // Avoid rebuilding if same date is selected
      if (DateUtils.isSameDay(currentState.selectedDate, event.date)) {
        return;
      }

      emit(currentState.copyWith(selectedDate: event.date));
    }
  }
}
