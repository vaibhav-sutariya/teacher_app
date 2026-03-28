import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/paper_model.dart';
import '../repositories/paper_repository.dart';

part 'paper_event.dart';
part 'paper_state.dart';

class PaperBloc extends Bloc<PaperEvent, PaperState> {
  final PaperRepository repository;

  PaperBloc({required this.repository}) : super(PaperInitial()) {
    on<PaperLoaded>(_onPaperLoaded);
  }

  Future<void> _onPaperLoaded(
    PaperLoaded event,
    Emitter<PaperState> emit,
  ) async {
    emit(PaperLoading());
    final result = await repository.getPapers();
    result.fold(
      (failure) => emit(PaperError(failure.message)),
      (paperList) => emit(PaperLoadedState(paperList)),
    );
  }
}
