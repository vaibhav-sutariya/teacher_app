part of 'class_test_bloc.dart';

abstract class ClassTestState extends Equatable {
  const ClassTestState();

  @override
  List<Object> get props => [];
}

class ClassTestInitial extends ClassTestState {}

class ClassTestLoading extends ClassTestState {}

class ClassTestLoadedState extends ClassTestState {
  final List<ClassTestModel> classTestList;

  const ClassTestLoadedState(this.classTestList);

  @override
  List<Object> get props => [classTestList];
}

class ClassTestError extends ClassTestState {
  final String message;

  const ClassTestError(this.message);

  @override
  List<Object> get props => [message];
}
