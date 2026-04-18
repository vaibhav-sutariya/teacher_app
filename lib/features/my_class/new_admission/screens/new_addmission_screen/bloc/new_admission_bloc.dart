import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../models/new_admission_model.dart';

part 'new_admission_event.dart';
part 'new_admission_state.dart';

class NewAdmissionBloc extends Bloc<NewAdmissionEvent, NewAdmissionState> {
  NewAdmissionBloc() : super(NewAdmissionState.initial()) {
    on<LoadMonthAdmissions>(_onLoadMonthAdmissions);
    on<ChangeAdmissionMonth>(_onChangeMonth);
  }

  void _onLoadMonthAdmissions(
    LoadMonthAdmissions event,
    Emitter<NewAdmissionState> emit,
  ) async {
    emit(state.copyWith(status: NewAdmissionStatus.loading));
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Mock data for June 2025 based on the user's image
      final mockAdmissions = [
        NewAdmissionModel(
          date: DateTime(2025, 6, 24),
          admissionCount: 1,
          markerColor: const Color(0xFFA7FFEB), // Light Green
        ),
        NewAdmissionModel(
          date: DateTime(2025, 6, 21),
          admissionCount: 1,
          markerColor: const Color(0xFFCE93D8), // Purple
        ),
        NewAdmissionModel(
          date: DateTime(2025, 6, 17),
          admissionCount: 1,
          markerColor: const Color(0xFFFFE0B2), // Peach/Orange
        ),
        NewAdmissionModel(
          date: DateTime(2025, 6, 11),
          admissionCount: 2,
          markerColor: const Color(0xFFBBDEFB), // Light Blue
        ),
        NewAdmissionModel(
          date: DateTime(2025, 6, 10),
          admissionCount: 14,
          markerColor: const Color(0xFFC5A02B), // Mustard
        ),
        NewAdmissionModel(
          date: DateTime(2025, 6, 7),
          admissionCount: 6,
          markerColor: const Color(0xFFB39DDB), // Lavender
        ),
        NewAdmissionModel(
          date: DateTime(2025, 6, 5),
          admissionCount: 16,
          markerColor: const Color(0xFF7986CB), // Indigo
        ),
        NewAdmissionModel(
          date: DateTime(2025, 6, 4),
          admissionCount: 153,
          markerColor: const Color(0xFF1B5E20), // Dark Green
        ),
        NewAdmissionModel(
          date: DateTime(2025, 6, 2),
          admissionCount: 158,
          markerColor: const Color(0xFF80DEEA), // Cyan
        ),
      ];

      final total = mockAdmissions.fold<int>(
        0,
        (sum, item) => sum + item.admissionCount,
      );

      emit(
        state.copyWith(
          status: NewAdmissionStatus.loaded,
          admissions: mockAdmissions,
          selectedMonth: event.month,
          totalMonthAdmissions: total,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: NewAdmissionStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onChangeMonth(
    ChangeAdmissionMonth event,
    Emitter<NewAdmissionState> emit,
  ) {
    add(LoadMonthAdmissions(event.month));
  }
}
