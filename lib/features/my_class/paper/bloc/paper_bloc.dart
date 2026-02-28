import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/paper_model.dart';

part 'paper_event.dart';
part 'paper_state.dart';

class PaperBloc extends Bloc<PaperEvent, PaperState> {
  PaperBloc() : super(PaperInitial()) {
    on<PaperLoaded>(_onPaperLoaded);
  }

  Future<void> _onPaperLoaded(
    PaperLoaded event,
    Emitter<PaperState> emit,
  ) async {
    emit(PaperLoading());

    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Load mock data
      final paperList = PaperModel.getMockData();

      emit(PaperLoadedState(paperList));
    } catch (e) {
      emit(PaperError('Failed to load papers: ${e.toString()}'));
    }
  }
}
