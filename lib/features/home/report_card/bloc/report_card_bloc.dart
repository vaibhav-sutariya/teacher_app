import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/report_card_model.dart';

part 'report_card_event.dart';
part 'report_card_state.dart';

class ReportCardBloc extends Bloc<ReportCardEvent, ReportCardState> {
  ReportCardBloc() : super(ReportCardInitial()) {
    on<LoadReportCards>(_onLoadReportCards);
    on<ChangeAcademicYear>(_onChangeAcademicYear);
  }

  static const String defaultYear = '2024 - 2025';

  Future<void> _onLoadReportCards(
    LoadReportCards event,
    Emitter<ReportCardState> emit,
  ) async {
    final yearToLoad = event.year ?? defaultYear;
    emit(ReportCardLoading());
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 800));

      final reports = ReportCardModel.getMockData(yearToLoad);
      emit(ReportCardLoaded(reportCards: reports, selectedYear: yearToLoad));
    } catch (e) {
      emit(ReportCardError('Failed to load report cards: $e'));
    }
  }

  Future<void> _onChangeAcademicYear(
    ChangeAcademicYear event,
    Emitter<ReportCardState> emit,
  ) async {
    final currentState = state;
    if (currentState is ReportCardLoaded) {
      if (currentState.selectedYear == event.year) return;

      emit(ReportCardLoading());
      try {
        // Simulate network delay for filtering
        await Future.delayed(const Duration(milliseconds: 500));

        final reports = ReportCardModel.getMockData(event.year);
        emit(
          currentState.copyWith(reportCards: reports, selectedYear: event.year),
        );
      } catch (e) {
        emit(ReportCardError('Failed to change academic year: $e'));
      }
    } else {
      add(LoadReportCards(year: event.year));
    }
  }
}
