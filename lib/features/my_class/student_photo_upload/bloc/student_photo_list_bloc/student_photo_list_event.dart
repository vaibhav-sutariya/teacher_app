part of 'student_photo_list_bloc.dart';

abstract class StudentPhotoListEvent extends Equatable {
  const StudentPhotoListEvent();

  @override
  List<Object?> get props => [];
}

class LoadStudents extends StudentPhotoListEvent {
  final String className;
  const LoadStudents(this.className);

  @override
  List<Object?> get props => [className];
}

class SearchStudents extends StudentPhotoListEvent {
  final String query;
  const SearchStudents(this.query);

  @override
  List<Object?> get props => [query];
}

class UpdateStudentPhoto extends StudentPhotoListEvent {
  final String studentId;
  final String status; // 'uploaded'
  const UpdateStudentPhoto({required this.studentId, required this.status});

  @override
  List<Object?> get props => [studentId, status];
}
