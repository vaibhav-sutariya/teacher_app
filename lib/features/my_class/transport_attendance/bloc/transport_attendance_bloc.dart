import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'transport_attendance_event.dart';
part 'transport_attendance_state.dart';

class TransportAttendanceBloc
    extends Bloc<TransportAttendanceEvent, TransportAttendanceState> {
  TransportAttendanceBloc() : super(TransportAttendanceInitial()) {
    on<LoadTransportAttendance>((event, emit) async {
      emit(TransportAttendanceLoading());
      try {
        // Simulate network delay
        await Future.delayed(const Duration(seconds: 1));
        emit(TransportAttendanceLoaded());
      } catch (e) {
        emit(TransportAttendanceError(e.toString()));
      }
    });
  }
}
