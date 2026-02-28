part of 'homework_bloc.dart';

abstract class HomeworkEvent extends Equatable {
  const HomeworkEvent();

  @override
  List<Object?> get props => [];
}

class HomeworkLoaded extends HomeworkEvent {}

class HomeworkDateChanged extends HomeworkEvent {
  final DateTime date;

  const HomeworkDateChanged(this.date);

  @override
  List<Object?> get props => [date];
}
