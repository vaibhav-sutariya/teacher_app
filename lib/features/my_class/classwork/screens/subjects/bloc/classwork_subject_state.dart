import 'package:equatable/equatable.dart';

abstract class ClassworkSubjectState extends Equatable {
  const ClassworkSubjectState();

  @override
  List<Object?> get props => [];
}

class ClassworkSubjectInitial extends ClassworkSubjectState {}

class ClassworkSubjectLoading extends ClassworkSubjectState {}

class ClassworkSubjectLoaded extends ClassworkSubjectState {
  final List<String> subjects;
  const ClassworkSubjectLoaded(this.subjects);

  @override
  List<Object?> get props => [subjects];
}

class ClassworkSubjectError extends ClassworkSubjectState {
  final String message;
  const ClassworkSubjectError(this.message);

  @override
  List<Object?> get props => [message];
}
