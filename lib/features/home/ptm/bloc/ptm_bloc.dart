import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/ptm_model.dart';
import 'ptm_event.dart';
import 'ptm_state.dart';

class PtmBloc extends Bloc<PtmEvent, PtmState> {
  PtmBloc() : super(PtmInitial()) {
    on<LoadPtms>(_onLoadPtms);
  }

  Future<void> _onLoadPtms(LoadPtms event, Emitter<PtmState> emit) async {
    emit(PtmLoading());
    try {
      // Simulating network delay
      await Future.delayed(const Duration(milliseconds: 600));

      final ptms = PtmModel.getMockData();
      emit(PtmLoaded(ptms: ptms));
    } catch (e) {
      emit(PtmError(e.toString()));
    }
  }
}
