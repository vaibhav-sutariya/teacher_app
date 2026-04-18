part of 'calendar_bloc.dart';

enum CalendarStatus { initial, loading, loaded, error }

class CalendarState extends Equatable {
  final CalendarStatus status;
  final List<CalendarEventModel> events;
  final DateTime selectedDate;
  final DateTime focusedMonth;
  final String? errorMessage;

  const CalendarState({
    this.status = CalendarStatus.initial,
    this.events = const [],
    required this.selectedDate,
    required this.focusedMonth,
    this.errorMessage,
  });

  factory CalendarState.initial() {
    final now = DateTime.now();
    return CalendarState(
      selectedDate: DateTime(now.year, now.month, now.day),
      focusedMonth: DateTime(now.year, now.month, 1),
    );
  }

  CalendarState copyWith({
    CalendarStatus? status,
    List<CalendarEventModel>? events,
    DateTime? selectedDate,
    DateTime? focusedMonth,
    String? errorMessage,
  }) {
    return CalendarState(
      status: status ?? this.status,
      events: events ?? this.events,
      selectedDate: selectedDate ?? this.selectedDate,
      focusedMonth: focusedMonth ?? this.focusedMonth,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    events,
    selectedDate,
    focusedMonth,
    errorMessage,
  ];

  /// Get events for a specific day
  List<CalendarEventModel> getEventsForDay(DateTime day) {
    return events.where((e) {
      return e.date.year == day.year &&
          e.date.month == day.month &&
          e.date.day == day.day;
    }).toList();
  }

  /// Get selected day's events
  List<CalendarEventModel> get selectedDateEvents =>
      getEventsForDay(selectedDate);
}
