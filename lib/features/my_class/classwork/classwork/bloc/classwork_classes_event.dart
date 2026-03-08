import 'package:equatable/equatable.dart';

abstract class ClassworkClassesEvent extends Equatable {
  const ClassworkClassesEvent();

  @override
  List<Object?> get props => [];
}

class ClassworkClassesLoaded extends ClassworkClassesEvent {}

class ClassworkClassesDateChanged extends ClassworkClassesEvent {
  final DateTime date;
  const ClassworkClassesDateChanged(this.date);

  @override
  List<Object?> get props => [date];
}
