part of 'class_test_bloc.dart';

abstract class ClassTestEvent extends Equatable {
  const ClassTestEvent();

  @override
  List<Object> get props => [];
}

class ClassTestLoaded extends ClassTestEvent {}
