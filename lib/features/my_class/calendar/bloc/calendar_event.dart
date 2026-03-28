part of 'calendar_bloc.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object?> get props => [];
}

class LoadCalendarEvents extends CalendarEvent {
  final DateTime month;
  const LoadCalendarEvents(this.month);

  @override
  List<Object?> get props => [month];
}

class SelectCalendarDate extends CalendarEvent {
  final DateTime date;
  const SelectCalendarDate(this.date);

  @override
  List<Object?> get props => [date];
}

class ChangeCalendarMonth extends CalendarEvent {
  final DateTime month;
  const ChangeCalendarMonth(this.month);

  @override
  List<Object?> get props => [month];
}
