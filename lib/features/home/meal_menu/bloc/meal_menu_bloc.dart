import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/meal_menu_model.dart';

part 'meal_menu_event.dart';
part 'meal_menu_state.dart';

class MealMenuBloc extends Bloc<MealMenuEvent, MealMenuState> {
  MealMenuBloc() : super(MealMenuInitial()) {
    on<MealMenuLoaded>(_onLoaded);
    on<MealMenuDateChanged>(_onDateChanged);
  }

  void _onLoaded(MealMenuLoaded event, Emitter<MealMenuState> emit) async {
    emit(MealMenuLoading());
    try {
      // simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      final today = DateTime.now();
      final allMeals = MealMenuEntity.getMockData();

      // Filter for today initially
      final filteredMeals = _filterMealsByDate(allMeals, today);

      emit(MealMenuLoadedState(mealList: filteredMeals, selectedDate: today));
    } catch (e) {
      emit(MealMenuError(e.toString()));
    }
  }

  void _onDateChanged(MealMenuDateChanged event, Emitter<MealMenuState> emit) {
    if (state is MealMenuLoadedState) {
      final currentState = state as MealMenuLoadedState;
      final allMeals = MealMenuEntity.getMockData();

      final filteredMeals = _filterMealsByDate(allMeals, event.selectedDate);

      emit(
        currentState.copyWith(
          mealList: filteredMeals,
          selectedDate: event.selectedDate,
        ),
      );
    }
  }

  List<MealMenuEntity> _filterMealsByDate(
    List<MealMenuEntity> meals,
    DateTime date,
  ) {
    return meals.where((meal) {
      return meal.date.year == date.year &&
          meal.date.month == date.month &&
          meal.date.day == date.day;
    }).toList();
  }
}
