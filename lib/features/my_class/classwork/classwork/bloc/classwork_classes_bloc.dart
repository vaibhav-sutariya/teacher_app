import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'classwork_classes_event.dart';
import 'classwork_classes_state.dart';

class ClassworkClassesBloc
    extends Bloc<ClassworkClassesEvent, ClassworkClassesState> {
  final List<String> _mockClasses = [
    'LITTLE CHAMPS',
    'JR.KG',
    'SR.KG',
    '1st',
    '2nd',
    '3rd',
    '4th',
    '5th',
  ];

  ClassworkClassesBloc() : super(ClassworkClassesInitial()) {
    on<ClassworkClassesLoaded>(_onLoaded);
    on<ClassworkClassesDateChanged>(_onDateChanged);
  }

  Future<void> _onLoaded(
    ClassworkClassesLoaded event,
    Emitter<ClassworkClassesState> emit,
  ) async {
    emit(ClassworkClassesLoading());
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    emit(
      ClassworkClassesLoadedState(classes: _mockClasses, selectedDate: today),
    );
  }

  void _onDateChanged(
    ClassworkClassesDateChanged event,
    Emitter<ClassworkClassesState> emit,
  ) {
    if (state is ClassworkClassesLoadedState) {
      final currentState = state as ClassworkClassesLoadedState;
      if (DateUtils.isSameDay(currentState.selectedDate, event.date)) return;

      emit(currentState.copyWith(selectedDate: event.date));
    }
  }
}
