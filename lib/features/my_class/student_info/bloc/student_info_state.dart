part of 'student_info_bloc.dart';

abstract class StudentInfoState extends Equatable {
  const StudentInfoState();

  @override
  List<Object> get props => [];
}

class StudentInfoInitial extends StudentInfoState {}

class StudentInfoLoading extends StudentInfoState {}

class StudentInfoLoaded extends StudentInfoState {}

class StudentInfoError extends StudentInfoState {
  final String message;
  const StudentInfoError(this.message);
  @override
  List<Object> get props => [message];
}
