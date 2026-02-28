import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/gate_pass_model.dart';
import 'gate_pass_event.dart';
import 'gate_pass_state.dart';

class GatePassBloc extends Bloc<GatePassEvent, GatePassState> {
  GatePassBloc() : super(const GatePassState()) {
    on<LoadGatePasses>(_onLoadGatePasses);
    on<SwitchTab>(_onSwitchTab);
  }

  void _onLoadGatePasses(
    LoadGatePasses event,
    Emitter<GatePassState> emit,
  ) async {
    emit(state.copyWith(status: GatePassPageStatus.loading));
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      final allPasses = GatePassModel.getMockData();
      final filtered = _filterPasses(allPasses, state.selectedTabIndex);
      emit(
        state.copyWith(
          status: GatePassPageStatus.loaded,
          allGatePasses: allPasses,
          filteredGatePasses: filtered,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: GatePassPageStatus.error,
          errorMessage: 'Failed to load gate passes',
        ),
      );
    }
  }

  void _onSwitchTab(SwitchTab event, Emitter<GatePassState> emit) {
    final filtered = _filterPasses(state.allGatePasses, event.index);
    emit(
      state.copyWith(
        selectedTabIndex: event.index,
        filteredGatePasses: filtered,
      ),
    );
  }

  List<GatePassModel> _filterPasses(List<GatePassModel> passes, int index) {
    if (index == 0) {
      return passes.where((p) => p.type == GatePassType.student).toList();
    } else {
      return passes.where((p) => p.type == GatePassType.parent).toList();
    }
  }
}
