import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/fees_model.dart';

part 'fees_event.dart';
part 'fees_state.dart';

class FeesBloc extends Bloc<FeesEvent, FeesState> {
  FeesBloc() : super(FeesState(selectedMonth: DateTime.now())) {
    on<LoadFeesData>(_onLoadFeesData);
    on<ChangeSelectedMonth>(_onChangeSelectedMonth);
  }

  Future<void> _onLoadFeesData(
    LoadFeesData event,
    Emitter<FeesState> emit,
  ) async {
    emit(state.copyWith(status: FeesStatus.loading, selectedMonth: event.month));
    try {
      // Mock API call delay
      await Future.delayed(const Duration(milliseconds: 600));
      
      final summary = FeesSummaryModel.mock(event.month);
      final collections = FeesSummaryModel.mockCollections(event.month);
      
      emit(state.copyWith(
        status: FeesStatus.loaded,
        summary: summary,
        collections: collections,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FeesStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onChangeSelectedMonth(
    ChangeSelectedMonth event,
    Emitter<FeesState> emit,
  ) {
    // Simply trigger historical data load for the new month
    add(LoadFeesData(event.month));
  }
}
