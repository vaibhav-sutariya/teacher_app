import 'package:equatable/equatable.dart';

abstract class MealMenuClassesEvent extends Equatable {
  const MealMenuClassesEvent();

  @override
  List<Object?> get props => [];
}

class MealMenuClassesLoaded extends MealMenuClassesEvent {}

class MealMenuClassesDateChanged extends MealMenuClassesEvent {
  final DateTime selectedDate;
  const MealMenuClassesDateChanged(this.selectedDate);

  @override
  List<Object?> get props => [selectedDate];
}
