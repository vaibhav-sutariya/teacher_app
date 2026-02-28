import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/calendar_event_model.dart';
import 'calendar_event.dart';
import 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(CalendarState.initial()) {
    on<LoadEvents>(_onLoadEvents);
    on<SelectDate>(_onSelectDate);
    on<ChangeMonth>(_onChangeMonth);
  }

  void _onLoadEvents(LoadEvents event, Emitter<CalendarState> emit) async {
    emit(state.copyWith(status: CalendarStatus.loading));
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));
      final allEvents = CalendarEventModel.getMockData();

      // Group events by date
      final eventsMap = <DateTime, List<CalendarEventModel>>{};
      for (var event in allEvents) {
        final date = DateTime(
          event.date.year,
          event.date.month,
          event.date.day,
        );
        if (eventsMap.containsKey(date)) {
          eventsMap[date]!.add(event);
        } else {
          eventsMap[date] = [event];
        }
      }

      // Filter events for current selected date
      final selectedDateKey = DateTime(
        state.selectedDate.year,
        state.selectedDate.month,
        state.selectedDate.day,
      );
      final selectedDateEvents = eventsMap[selectedDateKey] ?? [];

      emit(
        state.copyWith(
          status: CalendarStatus.loaded,
          eventsMap: eventsMap,
          selectedDateEvents: selectedDateEvents,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CalendarStatus.error,
          errorMessage: 'Failed to load events',
        ),
      );
    }
  }

  void _onSelectDate(SelectDate event, Emitter<CalendarState> emit) {
    final dateKey = DateTime(event.date.year, event.date.month, event.date.day);
    final events = state.eventsMap[dateKey] ?? [];

    emit(state.copyWith(selectedDate: event.date, selectedDateEvents: events));
  }

  void _onChangeMonth(ChangeMonth event, Emitter<CalendarState> emit) {
    emit(state.copyWith(focusedMonth: event.month));
  }
}
