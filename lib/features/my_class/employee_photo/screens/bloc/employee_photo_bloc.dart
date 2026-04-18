import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'employee_photo_event.dart';
part 'employee_photo_state.dart';

class EmployeePhotoBloc extends Bloc<EmployeePhotoEvent, EmployeePhotoState> {
  EmployeePhotoBloc() : super(EmployeePhotoInitial()) {
    on<LoadEmployeePhoto>((event, emit) async {
      emit(EmployeePhotoLoading());
      try {
        // Simulate network delay
        await Future.delayed(const Duration(seconds: 1));
        emit(EmployeePhotoLoaded());
      } catch (e) {
        emit(EmployeePhotoError(e.toString()));
      }
    });
  }
}
