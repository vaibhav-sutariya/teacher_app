part of 'student_info_bloc.dart';

class StudentInfoState extends Equatable {
  final int tabIndex;
  final List<ClassInfoModel> classes;
  final List<StudentModel> students;
  final String searchQuery;
  final bool isLoading;
  final String? error;

  const StudentInfoState({
    this.tabIndex = 0,
    this.classes = const [],
    this.students = const [],
    this.searchQuery = '',
    this.isLoading = false,
    this.error,
  });

  factory StudentInfoState.initial() {
    return const StudentInfoState();
  }

  StudentInfoState copyWith({
    int? tabIndex,
    List<ClassInfoModel>? classes,
    List<StudentModel>? students,
    String? searchQuery,
    bool? isLoading,
    String? error,
  }) {
    return StudentInfoState(
      tabIndex: tabIndex ?? this.tabIndex,
      classes: classes ?? this.classes,
      students: students ?? this.students,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [tabIndex, classes, students, searchQuery, isLoading, error];
}
