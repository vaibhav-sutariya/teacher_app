part of 'punch_approvals_bloc.dart';

abstract class PunchApprovalsState extends Equatable {
  const PunchApprovalsState();

  @override
  List<Object?> get props => [];
}

class PunchApprovalsInitial extends PunchApprovalsState {}

class PunchApprovalsLoading extends PunchApprovalsState {}

class PunchApprovalsLoaded extends PunchApprovalsState {
  final List<PunchApproval> allApprovals;
  final int selectedTabIndex;

  const PunchApprovalsLoaded({
    required this.allApprovals,
    this.selectedTabIndex = 0,
  });

  List<PunchApproval> get pendingList => allApprovals
      .where((a) => a.status == PunchApprovalStatus.pending)
      .toList();

  List<PunchApproval> get approvedList => allApprovals
      .where((a) => a.status == PunchApprovalStatus.approved)
      .toList();

  List<PunchApproval> get rejectedList => allApprovals
      .where((a) => a.status == PunchApprovalStatus.rejected)
      .toList();

  @override
  List<Object?> get props => [allApprovals, selectedTabIndex];
}

class PunchApprovalsError extends PunchApprovalsState {
  final String message;
  const PunchApprovalsError(this.message);

  @override
  List<Object?> get props => [message];
}
