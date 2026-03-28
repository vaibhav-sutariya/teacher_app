part of 'student_notice_bloc.dart';

abstract class StudentNoticeState extends Equatable {
  const StudentNoticeState();

  @override
  List<Object> get props => [];
}

class StudentNoticeInitial extends StudentNoticeState {}

class StudentNoticeLoading extends StudentNoticeState {}

class StudentNoticeLoaded extends StudentNoticeState {
  final List<StudentNoticeModel> notices;
  const StudentNoticeLoaded(this.notices);

  @override
  List<Object> get props => [notices];
}

class StudentNoticeError extends StudentNoticeState {
  final String message;
  const StudentNoticeError(this.message);
  @override
  List<Object> get props => [message];
}
