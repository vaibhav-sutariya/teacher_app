part of 'employee_photo_bloc.dart';

enum EmployeePhotoStatus { initial, loading, loaded, error }

class EmployeePhotoState extends Equatable {
  final EmployeePhotoStatus status;
  final List<EmployeeListModel> employees;
  final List<EmployeeListModel> filteredEmployees;
  final String? searchQuery;
  final String? errorMessage;

  const EmployeePhotoState({
    this.status = EmployeePhotoStatus.initial,
    this.employees = const [],
    this.filteredEmployees = const [],
    this.searchQuery,
    this.errorMessage,
  });

  EmployeePhotoState copyWith({
    EmployeePhotoStatus? status,
    List<EmployeeListModel>? employees,
    List<EmployeeListModel>? filteredEmployees,
    String? searchQuery,
    String? errorMessage,
  }) {
    return EmployeePhotoState(
      status: status ?? this.status,
      employees: employees ?? this.employees,
      filteredEmployees: filteredEmployees ?? this.filteredEmployees,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        employees,
        filteredEmployees,
        searchQuery,
        errorMessage,
      ];
}
