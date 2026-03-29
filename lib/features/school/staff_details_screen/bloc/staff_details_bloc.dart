import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/staff_model.dart';

part 'staff_details_event.dart';
part 'staff_details_state.dart';

class StaffDetailsBloc extends Bloc<StaffDetailsEvent, StaffDetailsState> {
  StaffDetailsBloc() : super(const StaffDetailsState(status: StaffDetailsStatus.initial)) {
    on<LoadStaffList>(_onLoadStaffList);
    on<SearchStaff>(_onSearchStaff);
  }

  Future<void> _onLoadStaffList(
    LoadStaffList event,
    Emitter<StaffDetailsState> emit,
  ) async {
    emit(state.copyWith(status: StaffDetailsStatus.loading));
    try {
      // Mock API delay
      await Future.delayed(const Duration(milliseconds: 500));
      final staffList = [...StaffMember.getMockStaff()];
      
      // Sort alphabetically
      staffList.sort((a, b) => a.name.compareTo(b.name));
      
      emit(state.copyWith(
        status: StaffDetailsStatus.loaded,
        originalList: staffList,
        filteredList: staffList,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: StaffDetailsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onSearchStaff(
    SearchStaff event,
    Emitter<StaffDetailsState> emit,
  ) {
    if (event.query.isEmpty) {
      emit(state.copyWith(filteredList: state.originalList));
      return;
    }

    final filtered = state.originalList.where((staff) =>
      staff.name.toLowerCase().contains(event.query.toLowerCase()) ||
      staff.designation.toLowerCase().contains(event.query.toLowerCase())
    ).toList();

    emit(state.copyWith(filteredList: filtered));
  }
}
