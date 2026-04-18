import 'package:equatable/equatable.dart';

abstract class HomeworkState extends Equatable {
  const HomeworkState();

  @override
  List<Object?> get props => [];
}

class HomeworkInitial extends HomeworkState {}

class HomeworkLoading extends HomeworkState {}

class HomeworkLoadedState extends HomeworkState {
  final List<String> classes;
  final DateTime selectedDate;

  const HomeworkLoadedState({
    required this.classes,
    required this.selectedDate,
  });

  HomeworkLoadedState copyWith({
    List<String>? classes,
    DateTime? selectedDate,
  }) {
    return HomeworkLoadedState(
      classes: classes ?? this.classes,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }

  @override
  List<Object?> get props => [classes, selectedDate];
}

class HomeworkError extends HomeworkState {
  final String message;

  const HomeworkError(this.message);

  @override
  List<Object?> get props => [message];
}
