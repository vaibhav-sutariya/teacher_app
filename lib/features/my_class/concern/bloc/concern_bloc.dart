import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/concern_model.dart';

part 'concern_event.dart';
part 'concern_state.dart';

class ConcernBloc extends Bloc<ConcernEvent, ConcernState> {
  ConcernBloc() : super(ConcernInitial()) {
    on<LoadConcerns>(_onLoadConcerns);
    on<FilterConcerns>(_onFilterConcerns);
  }

  Future<void> _onLoadConcerns(
    LoadConcerns event,
    Emitter<ConcernState> emit,
  ) async {
    emit(ConcernLoading());
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 800));

      final allConcerns = ConcernModel.getMockData();
      // Initial filter for 'Open' (index 0)
      final filtered = allConcerns
          .where((c) => c.status == ConcernStatus.open)
          .toList();

      emit(
        ConcernLoaded(
          allConcerns: allConcerns,
          filteredConcerns: filtered,
          selectedTabIndex: 0,
        ),
      );
    } catch (e) {
      emit(ConcernError('Failed to load concerns: $e'));
    }
  }

  void _onFilterConcerns(FilterConcerns event, Emitter<ConcernState> emit) {
    final currentState = state;
    if (currentState is ConcernLoaded) {
      final tabIndex = event.tabIndex;
      ConcernStatus targetStatus;

      switch (tabIndex) {
        case 0:
          targetStatus = ConcernStatus.open;
          break;
        case 1:
          targetStatus = ConcernStatus.inProcess;
          break;
        case 2:
          targetStatus = ConcernStatus.closed;
          break;
        default:
          targetStatus = ConcernStatus.open;
      }

      final filtered = currentState.allConcerns
          .where((c) => c.status == targetStatus)
          .toList();

      emit(
        currentState.copyWith(
          filteredConcerns: filtered,
          selectedTabIndex: tabIndex,
        ),
      );
    }
  }
}
