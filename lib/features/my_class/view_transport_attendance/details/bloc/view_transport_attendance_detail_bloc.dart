import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/view_transport_attendance_detail_repository.dart';
import 'view_transport_attendance_detail_event.dart';
import 'view_transport_attendance_detail_state.dart';

export 'view_transport_attendance_detail_event.dart';
export 'view_transport_attendance_detail_state.dart';

class ViewTransportAttendanceDetailBloc
    extends
        Bloc<
          ViewTransportAttendanceDetailEvent,
          ViewTransportAttendanceDetailState
        > {
  final ViewTransportAttendanceDetailRepository _repository;

  ViewTransportAttendanceDetailBloc({
    ViewTransportAttendanceDetailRepository? repository,
  }) : _repository = repository ?? ViewTransportAttendanceDetailRepository(),
       super(const ViewTransportAttendanceDetailState()) {
    on<LoadTransportDetailsEvent>((event, emit) async {
      emit(state.clearError().copyWith(isLoading: true));
      try {
        final students = await _repository.getStudentsByRouteAndDate(
          event.route,
          event.date,
        );
        emit(state.copyWith(isLoading: false, students: students));
      } catch (e) {
        emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      }
    });
  }
}
