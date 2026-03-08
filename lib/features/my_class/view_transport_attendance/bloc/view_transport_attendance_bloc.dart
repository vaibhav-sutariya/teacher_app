import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'view_transport_attendance_event.dart';
part 'view_transport_attendance_state.dart';

class ViewTransportAttendanceBloc
    extends Bloc<ViewTransportAttendanceEvent, ViewTransportAttendanceState> {
  ViewTransportAttendanceBloc() : super(ViewTransportAttendanceInitial()) {
    on<LoadViewTransportAttendance>((event, emit) async {
      emit(ViewTransportAttendanceLoading());
      try {
        // Simulate network delay
        await Future.delayed(const Duration(seconds: 1));
        emit(ViewTransportAttendanceLoaded());
      } catch (e) {
        emit(ViewTransportAttendanceError(e.toString()));
      }
    });
  }
}
