part of 'classwork_bloc.dart';

abstract class ClassworkEvent extends Equatable {
  const ClassworkEvent();

  @override
  List<Object?> get props => [];
}

class ClassworkLoaded extends ClassworkEvent {}

class ClassworkDateChanged extends ClassworkEvent {
  final DateTime date;

  const ClassworkDateChanged(this.date);

  @override
  List<Object?> get props => [date];
}
