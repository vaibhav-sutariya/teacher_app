part of 'approvals_bloc.dart';

abstract class ApprovalsEvent extends Equatable {
  const ApprovalsEvent();

  @override
  List<Object?> get props => [];
}

class LoadApprovals extends ApprovalsEvent {}

class ChangeTab extends ApprovalsEvent {
  final int index;
  const ChangeTab(this.index);

  @override
  List<Object?> get props => [index];
}
