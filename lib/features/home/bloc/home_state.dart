import 'package:equatable/equatable.dart';
import '../models/home_event_model.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final DateTime selectedDate;
  final DateTime focusedMonth;
  final Map<DateTime, List<CalendarEventModel>> eventsMap; // Map date to events
  final List<CalendarEventModel> selectedDateEvents; // Events for selected date
  final String? errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    required this.selectedDate,
    required this.focusedMonth,
    this.eventsMap = const {},
    this.selectedDateEvents = const [],
    this.errorMessage,
  });

  factory HomeState.initial() {
    final now = DateTime.now();
    return HomeState(
      selectedDate: now,
      focusedMonth: DateTime(now.year, now.month),
    );
  }

  HomeState copyWith({
    HomeStatus? status,
    DateTime? selectedDate,
    DateTime? focusedMonth,
    Map<DateTime, List<CalendarEventModel>>? eventsMap,
    List<CalendarEventModel>? selectedDateEvents,
    String? errorMessage,
  }) {
    return HomeState(
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
