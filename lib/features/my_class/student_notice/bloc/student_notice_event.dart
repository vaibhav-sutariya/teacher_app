part of 'student_notice_bloc.dart';

abstract class StudentNoticeEvent extends Equatable {
  const StudentNoticeEvent();

  @override
  List<Object> get props => [];
}

class LoadStudentNotice extends StudentNoticeEvent {}
