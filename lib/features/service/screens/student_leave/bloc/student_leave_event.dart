part of 'student_leave_bloc.dart';

abstract class StudentLeaveEvent extends Equatable {
  const StudentLeaveEvent();

  @override
  List<Object> get props => [];
}

class LoadStudentLeaves extends StudentLeaveEvent {}

class ChangeStudentLeaveTab extends StudentLeaveEvent {
  final int index;
  const ChangeStudentLeaveTab(this.index);

  @override
  List<Object> get props => [index];
}
