import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/transport_attendance_repository.dart';
import 'transport_attendance_event.dart';
import 'transport_attendance_state.dart';

export 'transport_attendance_event.dart';
export 'transport_attendance_state.dart';

class TransportAttendanceBloc
    extends Bloc<TransportAttendanceEvent, TransportAttendanceState> {
  final TransportAttendanceRepository _repository;

  TransportAttendanceBloc({TransportAttendanceRepository? repository})
    : _repository = repository ?? TransportAttendanceRepository(),
      super(TransportAttendanceState.initial()) {
    on<SelectRouteEvent>((event, emit) {
      emit(state.copyWith(selectedRoute: event.route));
      add(LoadStudentsEvent());
    });

    on<SelectDateEvent>((event, emit) {
      emit(state.copyWith(date: event.date));
    });

    on<LoadStudentsEvent>((event, emit) async {
      if (state.selectedRoute == null) return;
      emit(state.copyWith(isLoading: true, error: null));
      try {
        final students = await _repository.getStudentsByRoute(
          state.selectedRoute!,
        );
        emit(
          state.clearError().copyWith(
            isLoading: false,
            allStudents: students,
            filteredStudents: students,
          ),
        );
      } catch (e) {
        emit(state.copyWith(isLoading: false, error: e.toString()));
      }
    });

    on<SearchStudentsEvent>((event, emit) {
      final query = event.query.toLowerCase();
      final filtered = state.allStudents.where((student) {
        return student.name.toLowerCase().contains(query) ||
            student.rollNo.toLowerCase().contains(query);
      }).toList();
      emit(state.copyWith(searchQuery: query, filteredStudents: filtered));
    });

    on<ToggleAttendanceStatusEvent>((event, emit) {
      final updatedAll = state.allStudents.map((student) {
        if (student.id == event.studentId) {
          return student.copyWith(status: event.status);
        }
        return student;
      }).toList();

      final updatedFiltered = state.filteredStudents.map((student) {
        if (student.id == event.studentId) {
          return student.copyWith(status: event.status);
        }
        return student;
      }).toList();

      emit(
        state.clearError().copyWith(
          allStudents: updatedAll,
          filteredStudents: updatedFiltered,
        ),
      );
    });

    on<SubmitAttendanceEvent>((event, emit) async {
      if (state.selectedRoute == null) {
        emit(state.copyWith(error: 'Please select a route'));
        return;
      }

      emit(state.clearError().copyWith(isSubmitting: true));
      try {
        await _repository.submitAttendance(
          route: state.selectedRoute!,
          date: state.date,
          students: state.allStudents,
        );
        emit(state.copyWith(isSubmitting: false, submitSuccess: true));
      } catch (e) {
        emit(state.copyWith(isSubmitting: false, error: e.toString()));
      }
    });
  }
}
