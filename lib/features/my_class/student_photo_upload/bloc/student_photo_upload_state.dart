part of 'student_photo_upload_bloc.dart';

abstract class StudentPhotoUploadState extends Equatable {
  const StudentPhotoUploadState();

  @override
  List<Object> get props => [];
}

class StudentPhotoUploadInitial extends StudentPhotoUploadState {}

class StudentPhotoUploadLoading extends StudentPhotoUploadState {}

class StudentPhotoUploadLoaded extends StudentPhotoUploadState {}

class StudentPhotoUploadError extends StudentPhotoUploadState {
  final String message;
  const StudentPhotoUploadError(this.message);
  @override
  List<Object> get props => [message];
}
