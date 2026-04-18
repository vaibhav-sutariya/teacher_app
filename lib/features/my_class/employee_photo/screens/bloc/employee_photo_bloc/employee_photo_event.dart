part of 'employee_photo_bloc.dart';

abstract class EmployeePhotoEvent extends Equatable {
  const EmployeePhotoEvent();

  @override
  List<Object?> get props => [];
}

class LoadEmployees extends EmployeePhotoEvent {}

class SearchEmployees extends EmployeePhotoEvent {
  final String query;
  const SearchEmployees(this.query);

  @override
  List<Object?> get props => [query];
}

class UpdateEmployeePhoto extends EmployeePhotoEvent {
  final String employeeId;
  final String status; // 'uploaded'
  const UpdateEmployeePhoto({required this.employeeId, required this.status});

  @override
  List<Object?> get props => [employeeId, status];
}
