part of 'student_photo_list_bloc.dart';

enum StudentPhotoListStatus { initial, loading, loaded, error }

class StudentPhotoListState extends Equatable {
  final StudentPhotoListStatus status;
  final List<StudentListModel> students;
  final List<StudentListModel> filteredStudents;
  final String? className;
  final String? searchQuery;
  final String? errorMessage;

  const StudentPhotoListState({
    this.status = StudentPhotoListStatus.initial,
    this.students = const [],
    this.filteredStudents = const [],
    this.className,
    this.searchQuery,
    this.errorMessage,
  });

  StudentPhotoListState copyWith({
    StudentPhotoListStatus? status,
    List<StudentListModel>? students,
    List<StudentListModel>? filteredStudents,
    String? className,
    String? searchQuery,
    String? errorMessage,
  }) {
    return StudentPhotoListState(
      status: status ?? this.status,
      students: students ?? this.students,
      filteredStudents: filteredStudents ?? this.filteredStudents,
      className: className ?? this.className,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        students,
        filteredStudents,
        className,
        searchQuery,
        errorMessage,
      ];
}
