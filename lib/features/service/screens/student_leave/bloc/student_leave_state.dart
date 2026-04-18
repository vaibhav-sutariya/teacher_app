part of 'student_leave_bloc.dart';

abstract class StudentLeaveState extends Equatable {
  const StudentLeaveState();

  @override
  List<Object?> get props => [];
}

class StudentLeaveInitial extends StudentLeaveState {}

class StudentLeaveLoading extends StudentLeaveState {}

class StudentLeaveLoaded extends StudentLeaveState {
  final List<StudentLeaveModel> allLeaves;
  final int selectedTabIndex;

  const StudentLeaveLoaded({
    required this.allLeaves,
    this.selectedTabIndex = 0,
  });

  List<StudentLeaveModel> get pendingList => allLeaves
      .where((l) => l.status == StudentLeaveStatus.pending)
      .toList();

  List<StudentLeaveModel> get approvedList => allLeaves
      .where((l) => l.status == StudentLeaveStatus.approved)
      .toList();

  List<StudentLeaveModel> get rejectedList => allLeaves
      .where((l) => l.status == StudentLeaveStatus.rejected)
      .toList();

  @override
  List<Object?> get props => [allLeaves, selectedTabIndex];
}

class StudentLeaveError extends StudentLeaveState {
  final String message;
  const StudentLeaveError(this.message);

  @override
  List<Object?> get props => [message];
}
