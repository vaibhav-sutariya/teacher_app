part of 'assignment_bloc.dart';

abstract class AssignmentState extends Equatable {
  const AssignmentState();

  @override
  List<Object> get props => [];
}

class AssignmentLoading extends AssignmentState {}

class AssignmentLoadedState extends AssignmentState {
  final List<AssignmentModel> assignmentList;

  const AssignmentLoadedState(this.assignmentList);

  @override
  List<Object> get props => [assignmentList];
}

class AssignmentError extends AssignmentState {
  final String message;

  const AssignmentError(this.message);

  @override
  List<Object> get props => [message];
}
