part of 'punch_approvals_bloc.dart';

abstract class PunchApprovalsEvent extends Equatable {
  const PunchApprovalsEvent();

  @override
  List<Object?> get props => [];
}

class LoadPunchApprovals extends PunchApprovalsEvent {}

class ChangePunchApprovalTab extends PunchApprovalsEvent {
  final int index;
  const ChangePunchApprovalTab(this.index);

  @override
  List<Object?> get props => [index];
}

class ApprovePunchRequest extends PunchApprovalsEvent {
  final String id;
  const ApprovePunchRequest(this.id);

  @override
  List<Object?> get props => [id];
}

class RejectPunchRequest extends PunchApprovalsEvent {
  final String id;
  const RejectPunchRequest(this.id);

  @override
  List<Object?> get props => [id];
}
