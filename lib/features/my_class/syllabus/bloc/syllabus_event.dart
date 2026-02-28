part of 'syllabus_bloc.dart';

abstract class SyllabusEvent extends Equatable {
  const SyllabusEvent();

  @override
  List<Object> get props => [];
}

class SyllabusLoaded extends SyllabusEvent {}
