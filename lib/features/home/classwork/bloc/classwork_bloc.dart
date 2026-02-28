import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/classwork_model.dart';

part 'classwork_event.dart';
part 'classwork_state.dart';

class ClassworkBloc extends Bloc<ClassworkEvent, ClassworkState> {
  final List<ClassworkEntity> _allClasswork = ClassworkEntity.getMockData();

  ClassworkBloc() : super(ClassworkInitial()) {
    on<ClassworkLoaded>(_onLoaded);
    on<ClassworkDateChanged>(_onDateChanged);
  }

  void _onLoaded(ClassworkLoaded event, Emitter<ClassworkState> emit) async {
    emit(ClassworkLoading());
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Default to today
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final filteredList = _filterClassworkByDate(today);

    emit(
      ClassworkLoadedState(classworkList: filteredList, selectedDate: today),
    );
  }

  void _onDateChanged(
    ClassworkDateChanged event,
    Emitter<ClassworkState> emit,
  ) {
    if (state is ClassworkLoadedState) {
      final currentState = state as ClassworkLoadedState;
      // Avoid rebuilding if same date is selected (though UI shouldn't trigger it, good to have guard)
      if (DateUtils.isSameDay(currentState.selectedDate, event.date)) {
        return;
      }

      final filteredList = _filterClassworkByDate(event.date);
      emit(
        currentState.copyWith(
          selectedDate: event.date,
          classworkList: filteredList,
        ),
      );
    }
  }

  List<ClassworkEntity> _filterClassworkByDate(DateTime date) {
    return _allClasswork.where((classwork) {
      return DateUtils.isSameDay(classwork.date, date);
    }).toList();
  }
}
