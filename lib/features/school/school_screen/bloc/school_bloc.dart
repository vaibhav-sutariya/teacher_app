import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/school_model.dart';

part 'school_event.dart';
part 'school_state.dart';

class SchoolBloc extends Bloc<SchoolEvent, SchoolState> {
  SchoolBloc()
      : super(SchoolState(
          status: SchoolManagementStatus.loaded,
          modules: SchoolManagementModel.getMockModules().modules,
        )) {
    on<LoadSchoolModules>(_onLoadSchoolModules);
    on<RefreshSchoolModules>(_onRefreshSchoolModules);
  }

  void _onLoadSchoolModules(
    LoadSchoolModules event,
    Emitter<SchoolState> emit,
  ) {
    // Current state already has modules from constructor
    emit(state.copyWith(status: SchoolManagementStatus.loaded));
  }

  Future<void> _onRefreshSchoolModules(
    RefreshSchoolModules event,
    Emitter<SchoolState> emit,
  ) async {
    if (state.status == SchoolManagementStatus.loaded) {
      emit(state.copyWith(isRefreshing: true));
      try {
        await Future.delayed(const Duration(milliseconds: 800));
        final mockModules = SchoolManagementModel.getMockModules();
        emit(state.copyWith(
          status: SchoolManagementStatus.loaded,
          modules: mockModules.modules,
          isRefreshing: false,
        ));
      } catch (e) {
        emit(state.copyWith(
          status: SchoolManagementStatus.error,
          errorMessage: e.toString(),
          isRefreshing: false,
        ));
      }
    }
  }
}
