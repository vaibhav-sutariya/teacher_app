import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/homework_model.dart';

part 'homework_event.dart';
part 'homework_state.dart';

class HomeworkBloc extends Bloc<HomeworkEvent, HomeworkState> {
  final List<HomeworkEntity> _allHomework = HomeworkEntity.getMockData();

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
    await Future.delayed(const Duration(milliseconds: 800));

    // Default to today
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final filteredList = _filterHomeworkByDate(today);

    emit(HomeworkLoadedState(homeworkList: filteredList, selectedDate: today));
  }

  void _onDateChanged(HomeworkDateChanged event, Emitter<HomeworkState> emit) {
    if (state is HomeworkLoadedState) {
      final currentState = state as HomeworkLoadedState;
      // Avoid rebuilding if same date is selected
      if (DateUtils.isSameDay(currentState.selectedDate, event.date)) {
        return;
      }

      final filteredList = _filterHomeworkByDate(event.date);
      emit(
        currentState.copyWith(
          selectedDate: event.date,
          homeworkList: filteredList,
        ),
      );
    }
  }

  List<HomeworkEntity> _filterHomeworkByDate(DateTime date) {
    return _allHomework.where((homework) {
      return DateUtils.isSameDay(homework.date, date);
    }).toList();
  }
}
