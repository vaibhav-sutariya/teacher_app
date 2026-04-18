part of 'student_info_bloc.dart';

abstract class StudentInfoEvent extends Equatable {
  const StudentInfoEvent();

  @override
  List<Object?> get props => [];
}

class ChangeTabEvent extends StudentInfoEvent {
  final int index;
  const ChangeTabEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class LoadClassesEvent extends StudentInfoEvent {}

class SearchStudentsEvent extends StudentInfoEvent {
  final String query;
  const SearchStudentsEvent(this.query);

  @override
  List<Object?> get props => [query];
}
