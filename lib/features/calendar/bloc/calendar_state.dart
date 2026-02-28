import 'package:equatable/equatable.dart';
import '../models/calendar_event_model.dart';

enum CalendarStatus { initial, loading, loaded, error }

class CalendarState extends Equatable {
  final CalendarStatus status;
  final DateTime selectedDate;
  final DateTime focusedMonth;
  final Map<DateTime, List<CalendarEventModel>> eventsMap; // Map date to events
  final List<CalendarEventModel> selectedDateEvents; // Events for selected date
  final String? errorMessage;

  const CalendarState({
    this.status = CalendarStatus.initial,
    required this.selectedDate,
    required this.focusedMonth,
    this.eventsMap = const {},
    this.selectedDateEvents = const [],
    this.errorMessage,
  });

  factory CalendarState.initial() {
    final now = DateTime.now();
    return CalendarState(
      selectedDate: now,
      focusedMonth: DateTime(now.year, now.month),
    );
  }

  CalendarState copyWith({
    CalendarStatus? status,
    DateTime? selectedDate,
    DateTime? focusedMonth,
    Map<DateTime, List<CalendarEventModel>>? eventsMap,
    List<CalendarEventModel>? selectedDateEvents,
    String? errorMessage,
  }) {
    return CalendarState(
      status: status ?? this.status,
      selectedDate: selectedDate ?? this.selectedDate,
      focusedMonth: focusedMonth ?? this.focusedMonth,
      eventsMap: eventsMap ?? this.eventsMap,
      selectedDateEvents: selectedDateEvents ?? this.selectedDateEvents,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    selectedDate,
    focusedMonth,
    eventsMap,
    selectedDateEvents,
    errorMessage,
  ];
}
