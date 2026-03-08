part of 'employee_photo_bloc.dart';

abstract class EmployeePhotoState extends Equatable {
  const EmployeePhotoState();

  @override
  List<Object> get props => [];
}

class EmployeePhotoInitial extends EmployeePhotoState {}

class EmployeePhotoLoading extends EmployeePhotoState {}

class EmployeePhotoLoaded extends EmployeePhotoState {}

class EmployeePhotoError extends EmployeePhotoState {
  final String message;
  const EmployeePhotoError(this.message);
  @override
  List<Object> get props => [message];
}
