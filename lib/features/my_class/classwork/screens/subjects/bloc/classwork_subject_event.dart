import 'package:equatable/equatable.dart';

abstract class ClassworkSubjectEvent extends Equatable {
  const ClassworkSubjectEvent();

  @override
  List<Object?> get props => [];
}

class LoadClassworkSubjectsEvent extends ClassworkSubjectEvent {
  final String className;
  const LoadClassworkSubjectsEvent(this.className);

  @override
  List<Object?> get props => [className];
}
