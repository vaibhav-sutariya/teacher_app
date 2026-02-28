part of 'syllabus_bloc.dart';

abstract class SyllabusState extends Equatable {
  const SyllabusState();

  @override
  List<Object> get props => [];
}

class SyllabusLoading extends SyllabusState {}

class SyllabusLoadedState extends SyllabusState {
  final List<SyllabusModel> syllabusList;

  const SyllabusLoadedState(this.syllabusList);

  @override
  List<Object> get props => [syllabusList];
}

class SyllabusError extends SyllabusState {
  final String message;

  const SyllabusError(this.message);

  @override
  List<Object> get props => [message];
}
