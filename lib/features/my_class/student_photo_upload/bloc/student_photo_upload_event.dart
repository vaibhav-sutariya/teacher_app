part of 'student_photo_upload_bloc.dart';

abstract class StudentPhotoUploadEvent extends Equatable {
  const StudentPhotoUploadEvent();

  @override
  List<Object> get props => [];
}

class LoadStudentPhotoUpload extends StudentPhotoUploadEvent {}
