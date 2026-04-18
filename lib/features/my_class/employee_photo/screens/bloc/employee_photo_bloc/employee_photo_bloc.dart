import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teachers_app/features/my_class/employee_photo/models/employee_list_model.dart';

part 'employee_photo_event.dart';
part 'employee_photo_state.dart';

class EmployeePhotoBloc extends Bloc<EmployeePhotoEvent, EmployeePhotoState> {
  EmployeePhotoBloc() : super(const EmployeePhotoState()) {
    on<LoadEmployees>(_onLoadEmployees);
    on<SearchEmployees>(_onSearchEmployees);
    on<UpdateEmployeePhoto>(_onUpdateEmployeePhoto);
  }

  void _onLoadEmployees(LoadEmployees event, Emitter<EmployeePhotoState> emit) async {
    emit(state.copyWith(status: EmployeePhotoStatus.loading));
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      final mockEmployees = [
        const EmployeeListModel(
          id: '1',
          name: 'JOHN SMITH',
          designation: 'Accountant',
          isUploaded: true,
          photoUrl: 'https://via.placeholder.com/150',
        ),
        const EmployeeListModel(
          id: '2',
          name: 'EMILY DAVIS',
          designation: 'Senior Teacher',
          isUploaded: true,
          photoUrl: 'https://via.placeholder.com/150',
        ),
        const EmployeeListModel(
          id: '3',
          name: 'MICHAEL BROWN',
          designation: 'Clerk',
          isUploaded: true,
          photoUrl: 'https://via.placeholder.com/150',
        ),
        const EmployeeListModel(
          id: '4',
          name: 'SARAH WILSON',
          designation: 'Librarian',
          isUploaded: false,
          photoUrl: 'https://via.placeholder.com/150',
        ),
        const EmployeeListModel(
          id: '5',
          name: 'DAVID MILLER',
          designation: 'Security Head',
          isUploaded: true,
          photoUrl: 'https://via.placeholder.com/150',
        ),
        const EmployeeListModel(
          id: '6',
          name: 'JESSICA TAYLOR',
          designation: 'Sports Teacher',
          isUploaded: true,
          photoUrl: 'https://via.placeholder.com/150',
        ),
        const EmployeeListModel(
          id: '7',
          name: 'ROBERT MOORE',
          designation: 'Laboratory Assistant',
          isUploaded: false,
          photoUrl: 'https://via.placeholder.com/150',
        ),
        const EmployeeListModel(
          id: '8',
          name: 'LINDA ANDERSON',
          designation: 'Receptionist',
          isUploaded: true,
          photoUrl: 'https://via.placeholder.com/150',
        ),
      ];

      emit(state.copyWith(
        status: EmployeePhotoStatus.loaded,
        employees: mockEmployees,
        filteredEmployees: mockEmployees,
      ));
    } catch (e) {
      emit(state.copyWith(status: EmployeePhotoStatus.error, errorMessage: e.toString()));
    }
  }

  void _onSearchEmployees(SearchEmployees event, Emitter<EmployeePhotoState> emit) {
    final query = event.query.toLowerCase();
    final filtered = state.employees.where((e) {
      return e.name.toLowerCase().contains(query) || 
             e.designation.toLowerCase().contains(query);
    }).toList();

    emit(state.copyWith(
      searchQuery: query,
      filteredEmployees: filtered,
    ));
  }

  void _onUpdateEmployeePhoto(UpdateEmployeePhoto event, Emitter<EmployeePhotoState> emit) {
    final updatedEmployees = state.employees.map((e) {
      if (e.id == event.employeeId) {
        return EmployeeListModel(
          id: e.id,
          name: e.name,
          designation: e.designation,
          isUploaded: true,
          photoUrl: e.photoUrl,
        );
      }
      return e;
    }).toList();

    final filtered = updatedEmployees.where((e) {
      final query = state.searchQuery ?? '';
      return e.name.toLowerCase().contains(query) || 
             e.designation.toLowerCase().contains(query);
    }).toList();

    emit(state.copyWith(
      employees: updatedEmployees,
      filteredEmployees: filtered,
    ));
  }
}
