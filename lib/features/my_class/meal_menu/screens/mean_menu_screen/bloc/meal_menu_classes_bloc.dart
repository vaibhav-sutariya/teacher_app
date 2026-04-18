import 'package:flutter_bloc/flutter_bloc.dart';
import 'meal_menu_classes_event.dart';
import 'meal_menu_classes_state.dart';

class MealMenuClassesBloc
    extends Bloc<MealMenuClassesEvent, MealMenuClassesState> {
  final List<String> _allClasses = [
    'LITTLE CHAMPS',
    'JR.KG',
    'SR.KG',
    '1st',
    '2nd',
    '3rd',
    '4th',
    '5th',
  ];

  MealMenuClassesBloc() : super(MealMenuClassesInitial()) {
    on<MealMenuClassesLoaded>(_onLoaded);
    on<MealMenuClassesDateChanged>(_onDateChanged);
  }

  Future<void> _onLoaded(
    MealMenuClassesLoaded event,
    Emitter<MealMenuClassesState> emit,
  ) async {
    emit(MealMenuClassesLoading());
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    emit(MealMenuClassesLoadedState(classes: _allClasses, selectedDate: today));
  }

  void _onDateChanged(
    MealMenuClassesDateChanged event,
    Emitter<MealMenuClassesState> emit,
  ) {
    if (state is MealMenuClassesLoadedState) {
      final currentState = state as MealMenuClassesLoadedState;
      emit(currentState.copyWith(selectedDate: event.selectedDate));
    }
  }
}
