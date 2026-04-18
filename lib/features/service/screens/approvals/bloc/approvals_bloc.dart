import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../models/approval_models.dart';

part 'approvals_event.dart';
part 'approvals_state.dart';

class ApprovalsBloc extends Bloc<ApprovalsEvent, ApprovalsState> {
  ApprovalsBloc() : super(ApprovalsInitial()) {
    on<LoadApprovals>(_onLoadApprovals);
    on<ChangeTab>(_onChangeTab);
  }

  void _onLoadApprovals(LoadApprovals event, Emitter<ApprovalsState> emit) {
    emit(ApprovalsLoading());
    try {
      final approvals = ApprovalItem.getMockData();
      emit(ApprovalsLoaded(allApprovals: approvals));
    } catch (e) {
      emit(ApprovalsError(e.toString()));
    }
  }

  void _onChangeTab(ChangeTab event, Emitter<ApprovalsState> emit) {
    if (state is ApprovalsLoaded) {
      final currentState = state as ApprovalsLoaded;
      emit(ApprovalsLoaded(
        allApprovals: currentState.allApprovals,
        selectedTabIndex: event.index,
      ));
    }
  }
}
