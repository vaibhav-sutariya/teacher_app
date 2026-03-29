import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/punch_approval_model.dart';

// Events
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

// State
abstract class PunchApprovalsState extends Equatable {
  const PunchApprovalsState();
  @override
  List<Object?> get props => [];
}

class PunchApprovalsLoading extends PunchApprovalsState {}

class PunchApprovalsLoaded extends PunchApprovalsState {
  final List<PunchApproval> pendingList;
  final List<PunchApproval> approvedList;
  final List<PunchApproval> rejectedList;
  final int selectedTabIndex;

  const PunchApprovalsLoaded({
    required this.pendingList,
    required this.approvedList,
    required this.rejectedList,
    required this.selectedTabIndex,
  });

  PunchApprovalsLoaded copyWith({
    List<PunchApproval>? pendingList,
    List<PunchApproval>? approvedList,
    List<PunchApproval>? rejectedList,
    int? selectedTabIndex,
  }) {
    return PunchApprovalsLoaded(
      pendingList: pendingList ?? this.pendingList,
      approvedList: approvedList ?? this.approvedList,
      rejectedList: rejectedList ?? this.rejectedList,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
    );
  }

  @override
  List<Object?> get props => [pendingList, approvedList, rejectedList, selectedTabIndex];
}

class PunchApprovalsError extends PunchApprovalsState {
  final String message;
  const PunchApprovalsError(this.message);
  @override
  List<Object?> get props => [message];
}

// Bloc
class PunchApprovalsBloc extends Bloc<PunchApprovalsEvent, PunchApprovalsState> {
  PunchApprovalsBloc() : super(PunchApprovalsLoading()) {
    on<LoadPunchApprovals>(_onLoadPunchApprovals);
    on<ChangePunchApprovalTab>(_onChangePunchApprovalTab);
    on<ApprovePunchRequest>(_onApprovePunchRequest);
    on<RejectPunchRequest>(_onRejectPunchRequest);
  }

  Future<void> _onLoadPunchApprovals(
    LoadPunchApprovals event,
    Emitter<PunchApprovalsState> emit,
  ) async {
    emit(PunchApprovalsLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final allData = PunchApproval.getMockData();
      
      emit(PunchApprovalsLoaded(
        pendingList: allData.where((e) => e.status == PunchApprovalStatus.pending).toList(),
        approvedList: allData.where((e) => e.status == PunchApprovalStatus.approved).toList(),
        rejectedList: allData.where((e) => e.status == PunchApprovalStatus.rejected).toList(),
        selectedTabIndex: 0,
      ));
    } catch (e) {
      emit(PunchApprovalsError(e.toString()));
    }
  }

  void _onChangePunchApprovalTab(
    ChangePunchApprovalTab event,
    Emitter<PunchApprovalsState> emit,
  ) {
    if (state is PunchApprovalsLoaded) {
      emit((state as PunchApprovalsLoaded).copyWith(selectedTabIndex: event.index));
    }
  }

  Future<void> _onApprovePunchRequest(
    ApprovePunchRequest event,
    Emitter<PunchApprovalsState> emit,
  ) async {
    // Simulated approval
  }

  Future<void> _onRejectPunchRequest(
    RejectPunchRequest event,
    Emitter<PunchApprovalsState> emit,
  ) async {
    // Simulated rejection
  }
}
