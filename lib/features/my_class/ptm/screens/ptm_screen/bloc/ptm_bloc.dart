import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/ptm_repository.dart';
import 'ptm_event.dart';
import 'ptm_state.dart';

class PtmBloc extends Bloc<PtmEvent, PtmState> {
  final PtmRepository _ptmRepository;

  PtmBloc({PtmRepository? ptmRepository})
    : _ptmRepository = ptmRepository ?? MockPtmRepository(),
      super(PtmInitial()) {
    on<LoadPtms>(_onLoadPtms);
  }

  Future<void> _onLoadPtms(LoadPtms event, Emitter<PtmState> emit) async {
    emit(PtmLoading());
    try {
      final ptms = await _ptmRepository.getPtmList();
      emit(PtmLoaded(ptms: ptms));
    } catch (e) {
      emit(PtmError(e.toString()));
    }
  }
}
