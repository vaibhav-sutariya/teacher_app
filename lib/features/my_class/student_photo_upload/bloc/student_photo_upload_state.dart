part of 'student_photo_upload_bloc.dart';

enum StudentPhotoUploadStatus { initial, loading, loaded, error }

class StudentPhotoUploadState extends Equatable {
  final StudentPhotoUploadStatus status;
  final List<StudentPhotoClassModel> classes;
  final String? errorMessage;

  const StudentPhotoUploadState({
    this.status = StudentPhotoUploadStatus.initial,
    this.classes = const [],
    this.errorMessage,
  });

  StudentPhotoUploadState copyWith({
    StudentPhotoUploadStatus? status,
    List<StudentPhotoClassModel>? classes,
    String? errorMessage,
  }) {
    return StudentPhotoUploadState(
      status: status ?? this.status,
      classes: classes ?? this.classes,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, classes, errorMessage];
}
