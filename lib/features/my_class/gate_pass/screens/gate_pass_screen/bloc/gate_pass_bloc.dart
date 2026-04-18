import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/gate_pass_model.dart';
import 'gate_pass_event.dart';
import 'gate_pass_state.dart';

class GatePassBloc extends Bloc<GatePassEvent, GatePassState> {
  GatePassBloc() : super(const GatePassState()) {
    on<LoadGatePasses>(_onLoadGatePasses);
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
      emit(
        state.copyWith(
          status: GatePassPageStatus.loaded,
          allGatePasses: allPasses,
          filteredGatePasses: allPasses,
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
}
