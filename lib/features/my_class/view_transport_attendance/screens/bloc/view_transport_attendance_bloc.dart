import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/view_transport_attendance_repository.dart';
import 'view_transport_attendance_event.dart';
import 'view_transport_attendance_state.dart';

export 'view_transport_attendance_event.dart';
export 'view_transport_attendance_state.dart';

class ViewTransportAttendanceBloc
    extends Bloc<ViewTransportAttendanceEvent, ViewTransportAttendanceState> {
  final ViewTransportAttendanceRepository _repository;

  ViewTransportAttendanceBloc({ViewTransportAttendanceRepository? repository})
    : _repository = repository ?? ViewTransportAttendanceRepository(),
      super(ViewTransportAttendanceState.initial()) {
    on<LoadRoutesForDateEvent>((event, emit) async {
      emit(state.clearError().copyWith(isLoading: true));
      try {
        final routes = await _repository.getRoutesByDate(state.selectedDate);
        final pending = routes.where((r) => !r.isMarked).toList();
        final marked = routes.where((r) => r.isMarked).toList();
        emit(
          state.copyWith(
            isLoading: false,
            pendingRoutes: pending,
            markedRoutes: marked,
          ),
        );
      } catch (e) {
        emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      }
    });

    on<ChangeTabEvent>((event, emit) {
      if (state.selectedTabIndex != event.index) {
        emit(state.copyWith(selectedTabIndex: event.index));
      }
    });

    on<SelectDateEvent>((event, emit) {
      if (state.selectedDate != event.date) {
        emit(state.copyWith(selectedDate: event.date));
        add(LoadRoutesForDateEvent());
      }
    });

    // on<RefreshRoutesEvent>((event, emit) {
    //   add(LoadRoutesForDateEvent());
    // });
  }
}
