part of 'classwork_bloc.dart';

abstract class ClassworkState extends Equatable {
  const ClassworkState();

  @override
  List<Object?> get props => [];
}

class ClassworkInitial extends ClassworkState {}

class ClassworkLoading extends ClassworkState {}

class ClassworkLoadedState extends ClassworkState {
  final List<ClassworkEntity> classworkList;
  final DateTime selectedDate;

  const ClassworkLoadedState({
    required this.classworkList,
    required this.selectedDate,
  });

  ClassworkLoadedState copyWith({
    List<ClassworkEntity>? classworkList,
    DateTime? selectedDate,
  }) {
    return ClassworkLoadedState(
      classworkList: classworkList ?? this.classworkList,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }

  @override
  List<Object?> get props => [classworkList, selectedDate];
}

class ClassworkError extends ClassworkState {
  final String message;

  const ClassworkError(this.message);

  @override
  List<Object?> get props => [message];
}
