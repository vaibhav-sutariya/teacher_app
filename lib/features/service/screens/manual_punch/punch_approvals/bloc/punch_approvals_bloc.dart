import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teachers_app/features/service/models/punch_approval_model.dart';

part 'punch_approvals_event.dart';
part 'punch_approvals_state.dart';

class PunchApprovalsBloc extends Bloc<PunchApprovalsEvent, PunchApprovalsState> {
  PunchApprovalsBloc() : super(PunchApprovalsInitial()) {
    on<LoadPunchApprovals>(_onLoadPunchApprovals);
    on<ChangePunchApprovalTab>(_onChangePunchApprovalTab);
    on<ApprovePunchRequest>(_onApprovePunchRequest);
    on<RejectPunchRequest>(_onRejectPunchRequest);
  }

  void _onLoadPunchApprovals(
      LoadPunchApprovals event, Emitter<PunchApprovalsState> emit) {
    emit(PunchApprovalsLoading());
    try {
      final approvals = PunchApproval.getMockData();
      emit(PunchApprovalsLoaded(allApprovals: approvals));
    } catch (e) {
      emit(PunchApprovalsError(e.toString()));
    }
  }

  void _onChangePunchApprovalTab(
      ChangePunchApprovalTab event, Emitter<PunchApprovalsState> emit) {
    if (state is PunchApprovalsLoaded) {
      final currentState = state as PunchApprovalsLoaded;
      emit(PunchApprovalsLoaded(
        allApprovals: currentState.allApprovals,
        selectedTabIndex: event.index,
      ));
    }
  }

  void _onApprovePunchRequest(
      ApprovePunchRequest event, Emitter<PunchApprovalsState> emit) {
    // Mock approval logic
    if (state is PunchApprovalsLoaded) {
      final currentState = state as PunchApprovalsLoaded;
      final updatedList = currentState.allApprovals.map((a) {
        if (a.id == event.id) {
          return PunchApproval(
            id: a.id,
            name: a.name,
            date: a.date,
            time: a.time,
            type: a.type,
            status: PunchApprovalStatus.approved,
            reason: a.reason,
          );
        }
        return a;
      }).toList();
      emit(PunchApprovalsLoaded(
        allApprovals: updatedList,
        selectedTabIndex: currentState.selectedTabIndex,
      ));
    }
  }

  void _onRejectPunchRequest(
      RejectPunchRequest event, Emitter<PunchApprovalsState> emit) {
    // Mock rejection logic
    if (state is PunchApprovalsLoaded) {
      final currentState = state as PunchApprovalsLoaded;
      final updatedList = currentState.allApprovals.map((a) {
        if (a.id == event.id) {
          return PunchApproval(
            id: a.id,
            name: a.name,
            date: a.date,
            time: a.time,
            type: a.type,
            status: PunchApprovalStatus.rejected,
            reason: a.reason,
          );
        }
        return a;
      }).toList();
      emit(PunchApprovalsLoaded(
        allApprovals: updatedList,
        selectedTabIndex: currentState.selectedTabIndex,
      ));
    }
  }
}
