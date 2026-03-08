import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(CalendarInitial()) {
    on<LoadCalendar>((event, emit) async {
      emit(CalendarLoading());
      try {
        // Simulate network delay
        await Future.delayed(const Duration(seconds: 1));
        emit(CalendarLoaded());
      } catch (e) {
        emit(CalendarError(e.toString()));
      }
    });
  }
}
