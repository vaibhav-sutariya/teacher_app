import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/holiday_hw_model.dart';
import '../../../repositories/holiday_hw_repository.dart';

part 'add_holiday_hw_state.dart';

class AddHolidayHwBloc extends Bloc<AddHolidayHwEvent, AddHolidayHwState> {
  final HolidayHwRepository repository;

  AddHolidayHwBloc({required this.repository})
    : super(AddHolidayHwState.initial()) {
    on<UpdateHolidayHwClassEvent>(
      (event, emit) => emit(state.copyWith(selectedClass: event.selectedClass)),
    );
    on<UpdateHolidayHwSectionEvent>(
      (event, emit) => emit(state.copyWith(section: event.section)),
    );
    on<UpdateHolidayHwSubjectEvent>(
      (event, emit) => emit(state.copyWith(subject: event.subject)),
    );
    on<UpdateHolidayHwNameEvent>(
      (event, emit) => emit(state.copyWith(hwName: event.hwName)),
    );
    on<UpdateHolidayHwPdfUrlEvent>(
      (event, emit) => emit(state.copyWith(pdfUrl: event.pdfUrl)),
    );
    on<SubmitHolidayHwEvent>(_onSubmitHolidayHw);
  }

  Future<void> _onSubmitHolidayHw(
    SubmitHolidayHwEvent event,
    Emitter<AddHolidayHwState> emit,
  ) async {
    if (state.selectedClass == null ||
        state.section == null ||
        state.pdfUrl == null) {
      emit(state.copyWith(error: 'Required fields missing'));
      return;
    }

    emit(state.copyWith(isSubmitting: true, error: null));

    final homework = HolidayHwModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      subject: state.subject ?? 'General',
      type: state.hwName ?? 'Holiday Homework',
      color: const Color(0xFFE57373), // Reddish
      pdfUrl: state.pdfUrl!,
    );

    final result = await repository.addHolidayHw(homework);

    result.fold(
      (failure) =>
          emit(state.copyWith(isSubmitting: false, error: failure.message)),
      (_) => emit(state.copyWith(isSubmitting: false, submitSuccess: true)),
    );
  }
}
