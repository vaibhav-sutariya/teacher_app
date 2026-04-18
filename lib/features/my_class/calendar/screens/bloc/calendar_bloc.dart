import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/calendar_event_model.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(CalendarState.initial()) {
    on<LoadCalendarEvents>(_onLoadEvents);
    on<SelectCalendarDate>(_onSelectDate);
    on<ChangeCalendarMonth>(_onChangeMonth);
  }

  void _onLoadEvents(
    LoadCalendarEvents event,
    Emitter<CalendarState> emit,
  ) async {
    emit(state.copyWith(status: CalendarStatus.loading));
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Mock data for 2025-2026 as per screenshot
      final mockEvents = [
        // March 2026 events
        CalendarEventModel(
          date: DateTime(2026, 3, 2),
          title: 'Holi Holiday',
          targetClass: 'All Classes',
          type: CalendarEventType.holiday,
        ),
        CalendarEventModel(
          date: DateTime(2026, 3, 10),
          title: 'Science Exhibition',
          targetClass: 'Class 6-10',
          type: CalendarEventType.event,
        ),
        CalendarEventModel(
          date: DateTime(2026, 3, 18),
          title: 'Final Examination Starts',
          targetClass: 'All Classes',
          type: CalendarEventType.exam,
        ),
        CalendarEventModel(
          date: DateTime(2026, 3, 25),
          title: 'Special Project Submission',
          targetClass: 'Class 10-A',
          type: CalendarEventType.holiday,
          isSpecialHighlight: true,
        ),
        CalendarEventModel(
          date: DateTime(2026, 3, 27),
          title: 'Parent-Teacher Meeting',
          targetClass: 'All Classes',
          type: CalendarEventType.event,
          isSpecialHighlight: true,
        ),
        // June 2025 events (fallback/extra)
        CalendarEventModel(
          date: DateTime(2025, 6, 1),
          title: 'Rath Yatra (Holiday)',
          targetClass: 'All Classes',
          type: CalendarEventType.holiday,
        ),
      ];

      emit(
        state.copyWith(
          status: CalendarStatus.loaded,
          events: mockEvents,
          focusedMonth: event.month,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CalendarStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onSelectDate(SelectCalendarDate event, Emitter<CalendarState> emit) {
    emit(state.copyWith(selectedDate: event.date));
  }

  void _onChangeMonth(ChangeCalendarMonth event, Emitter<CalendarState> emit) {
    add(LoadCalendarEvents(event.month));
  }
}
