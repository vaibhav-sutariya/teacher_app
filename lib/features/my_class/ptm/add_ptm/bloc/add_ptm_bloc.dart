import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../repositories/ptm_repository.dart';
import 'add_ptm_event.dart';
import 'add_ptm_state.dart';

class AddPtmBloc extends Bloc<AddPtmEvent, AddPtmState> {
  final PtmRepository _ptmRepository;

  AddPtmBloc({PtmRepository? ptmRepository})
    : _ptmRepository = ptmRepository ?? MockPtmRepository(),
      super(const AddPtmState()) {
    on<TitleChanged>(_onTitleChanged);
    on<DateChanged>(_onDateChanged);
    on<TimeChanged>(_onTimeChanged);
    on<LocationChanged>(_onLocationChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<SubmitPtm>(_onSubmitPtm);
  }

  void _onTitleChanged(TitleChanged event, Emitter<AddPtmState> emit) {
    emit(state.copyWith(title: event.title, isSuccess: false));
  }

  void _onDateChanged(DateChanged event, Emitter<AddPtmState> emit) {
    emit(state.copyWith(date: event.date, isSuccess: false));
  }

  void _onTimeChanged(TimeChanged event, Emitter<AddPtmState> emit) {
    emit(state.copyWith(time: event.time, isSuccess: false));
  }

  void _onLocationChanged(LocationChanged event, Emitter<AddPtmState> emit) {
    emit(state.copyWith(location: event.location, isSuccess: false));
  }

  void _onDescriptionChanged(
    DescriptionChanged event,
    Emitter<AddPtmState> emit,
  ) {
    emit(state.copyWith(description: event.description, isSuccess: false));
  }

  Future<void> _onSubmitPtm(SubmitPtm event, Emitter<AddPtmState> emit) async {
    if (!state.isFormValid) return;

    emit(state.copyWith(isLoading: true, error: null));

    try {
      final dateStr = state.date != null
          ? DateFormat('dd MMM, yyyy').format(state.date!)
          : '';

      await _ptmRepository.createPtm(
        title: state.title,
        date: dateStr,
        time: state.time,
        location: state.location,
        description: state.description,
      );

      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Failed to schedule PTM: ${e.toString()}',
        ),
      );
    }
  }
}
