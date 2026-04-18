import 'package:equatable/equatable.dart';

abstract class MealMenuClassesState extends Equatable {
  const MealMenuClassesState();

  @override
  List<Object?> get props => [];
}

class MealMenuClassesInitial extends MealMenuClassesState {}

class MealMenuClassesLoading extends MealMenuClassesState {}

class MealMenuClassesLoadedState extends MealMenuClassesState {
  final List<String> classes;
  final DateTime selectedDate;

  const MealMenuClassesLoadedState({
    required this.classes,
    required this.selectedDate,
  });

  @override
  List<Object?> get props => [classes, selectedDate];

  MealMenuClassesLoadedState copyWith({
    List<String>? classes,
    DateTime? selectedDate,
  }) {
    return MealMenuClassesLoadedState(
      classes: classes ?? this.classes,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}

class MealMenuClassesError extends MealMenuClassesState {
  final String message;
  const MealMenuClassesError(this.message);

  @override
  List<Object?> get props => [message];
}
