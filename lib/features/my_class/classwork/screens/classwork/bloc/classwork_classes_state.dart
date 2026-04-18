import 'package:equatable/equatable.dart';

abstract class ClassworkClassesState extends Equatable {
  const ClassworkClassesState();

  @override
  List<Object?> get props => [];
}

class ClassworkClassesInitial extends ClassworkClassesState {}

class ClassworkClassesLoading extends ClassworkClassesState {}

class ClassworkClassesLoadedState extends ClassworkClassesState {
  final List<String> classes;
  final DateTime selectedDate;

  const ClassworkClassesLoadedState({
    required this.classes,
    required this.selectedDate,
  });

  @override
  List<Object?> get props => [classes, selectedDate];

  ClassworkClassesLoadedState copyWith({
    List<String>? classes,
    DateTime? selectedDate,
  }) {
    return ClassworkClassesLoadedState(
      classes: classes ?? this.classes,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}

class ClassworkClassesError extends ClassworkClassesState {
  final String message;
  const ClassworkClassesError(this.message);

  @override
  List<Object?> get props => [message];
}
