part of 'meal_menu_bloc.dart';

abstract class MealMenuEvent extends Equatable {
  const MealMenuEvent();

  @override
  List<Object> get props => [];
}

class MealMenuLoaded extends MealMenuEvent {}

class MealMenuDateChanged extends MealMenuEvent {
  final DateTime selectedDate;

  const MealMenuDateChanged(this.selectedDate);

  @override
  List<Object> get props => [selectedDate];
}
