part of 'meal_menu_bloc.dart';

abstract class MealMenuState extends Equatable {
  const MealMenuState();

  @override
  List<Object> get props => [];
}

class MealMenuInitial extends MealMenuState {}

class MealMenuLoading extends MealMenuState {}

class MealMenuLoadedState extends MealMenuState {
  final List<MealMenuEntity> mealList;
  final DateTime selectedDate;

  const MealMenuLoadedState({
    required this.mealList,
    required this.selectedDate,
  });

  @override
  List<Object> get props => [mealList, selectedDate];

  MealMenuLoadedState copyWith({
    List<MealMenuEntity>? mealList,
    DateTime? selectedDate,
  }) {
    return MealMenuLoadedState(
      mealList: mealList ?? this.mealList,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}

class MealMenuError extends MealMenuState {
  final String message;

  const MealMenuError(this.message);

  @override
  List<Object> get props => [message];
}
