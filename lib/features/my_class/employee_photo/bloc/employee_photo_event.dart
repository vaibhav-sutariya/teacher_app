part of 'employee_photo_bloc.dart';

abstract class EmployeePhotoEvent extends Equatable {
  const EmployeePhotoEvent();

  @override
  List<Object> get props => [];
}

class LoadEmployeePhoto extends EmployeePhotoEvent {}
