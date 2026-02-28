import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/summary_model.dart';

part 'summary_event.dart';
part 'summary_state.dart';

class SummaryBloc extends Bloc<SummaryEvent, SummaryState> {
  SummaryBloc() : super(SummaryInitial()) {
    on<LoadSummaryData>(_onLoadSummaryData);
    on<RefreshSummaryData>(_onRefreshSummaryData);
  }

  Future<void> _onLoadSummaryData(
    LoadSummaryData event,
    Emitter<SummaryState> emit,
  ) async {
    emit(SummaryLoading());
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 1000));

      final mockData = SummaryModel.getMockData();
      emit(SummaryLoaded(summary: mockData));
    } catch (e) {
      emit(SummaryError(e.toString()));
    }
  }

  Future<void> _onRefreshSummaryData(
    RefreshSummaryData event,
    Emitter<SummaryState> emit,
  ) async {
    if (state is SummaryLoaded) {
      final currentState = state as SummaryLoaded;
      emit(currentState.copyWith(isRefreshing: true));
      try {
        // Simulate API delay
        await Future.delayed(const Duration(milliseconds: 800));

        final mockData = SummaryModel.getMockData();
        emit(SummaryLoaded(summary: mockData));
      } catch (e) {
        emit(SummaryError(e.toString()));
      }
    }
  }
}
