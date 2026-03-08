import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'student_photo_upload_event.dart';
part 'student_photo_upload_state.dart';

class StudentPhotoUploadBloc
    extends Bloc<StudentPhotoUploadEvent, StudentPhotoUploadState> {
  StudentPhotoUploadBloc() : super(StudentPhotoUploadInitial()) {
    on<LoadStudentPhotoUpload>((event, emit) async {
      emit(StudentPhotoUploadLoading());
      try {
        // Simulate network delay
        await Future.delayed(const Duration(seconds: 1));
        emit(StudentPhotoUploadLoaded());
      } catch (e) {
        emit(StudentPhotoUploadError(e.toString()));
      }
    });
  }
}
