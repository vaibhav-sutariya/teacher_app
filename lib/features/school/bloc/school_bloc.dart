import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/school_model.dart';

part 'school_event.dart';
part 'school_state.dart';

class SchoolBloc extends Bloc<SchoolEvent, SchoolState> {
  SchoolBloc() : super(SchoolInitial()) {
    on<LoadSchoolData>(_onLoadSchoolData);
    on<RefreshSchoolData>(_onRefreshSchoolData);
  }

  Future<void> _onLoadSchoolData(
    LoadSchoolData event,
    Emitter<SchoolState> emit,
  ) async {
    emit(SchoolLoading());
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 1000));

      final mockData = SchoolModel.getMockData();
      emit(SchoolLoaded(summary: mockData));
    } catch (e) {
      emit(SchoolError(e.toString()));
    }
  }

  Future<void> _onRefreshSchoolData(
    RefreshSchoolData event,
    Emitter<SchoolState> emit,
  ) async {
    if (state is SchoolLoaded) {
      final currentState = state as SchoolLoaded;
      emit(currentState.copyWith(isRefreshing: true));
      try {
        // Simulate API delay
        await Future.delayed(const Duration(milliseconds: 800));

        final mockData = SchoolModel.getMockData();
        emit(SchoolLoaded(summary: mockData));
      } catch (e) {
        emit(SchoolError(e.toString()));
      }
    }
  }
}
