part of 'approvals_bloc.dart';

abstract class ApprovalsState extends Equatable {
  const ApprovalsState();

  @override
  List<Object?> get props => [];
}

class ApprovalsInitial extends ApprovalsState {}

class ApprovalsLoading extends ApprovalsState {}

class ApprovalsLoaded extends ApprovalsState {
  final List<ApprovalItem> allApprovals;
  final int selectedTabIndex;

  const ApprovalsLoaded({
    required this.allApprovals,
    this.selectedTabIndex = 0,
  });

  List<ApprovalItem> get peningApprovals => allApprovals
      .where((a) => a.status == ApprovalStatus.pending)
      .toList();

  List<ApprovalItem> get approvedApprovals => allApprovals
      .where((a) => a.status == ApprovalStatus.approved)
      .toList();

  List<ApprovalItem> get rejectedApprovals => allApprovals
      .where((a) => a.status == ApprovalStatus.rejected)
      .toList();

  @override
  List<Object?> get props => [allApprovals, selectedTabIndex];
}

class ApprovalsError extends ApprovalsState {
  final String message;
  const ApprovalsError(this.message);

  @override
  List<Object?> get props => [message];
}
