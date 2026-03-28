import 'package:equatable/equatable.dart';
import '../../models/student_notice_recipient_model.dart';

class AddStudentNoticeState extends Equatable {
  final String? selectedClass;
  final String? section;
  final DateTime date;
  final String title;
  final String content;
  final String? imagePath;
  final String? documentPath;

  // Student selection state
  final List<StudentNoticeRecipientModel> allStudents;
  final List<StudentNoticeRecipientModel> filteredStudents;
  final Set<String> selectedStudentIds;
  final String searchQuery;
  final bool isLoadingStudents;

  // Submission state
  final bool isSubmitting;
  final bool submitSuccess;
  final String? error;

  const AddStudentNoticeState({
    this.selectedClass,
    this.section,
    required this.date,
    this.title = '',
    this.content = '',
    this.imagePath,
    this.documentPath,
    this.allStudents = const [],
    this.filteredStudents = const [],
    this.selectedStudentIds = const {},
    this.searchQuery = '',
    this.isLoadingStudents = false,
    this.isSubmitting = false,
    this.submitSuccess = false,
    this.error,
  });

  factory AddStudentNoticeState.initial() {
    return AddStudentNoticeState(date: DateTime.now());
  }

  AddStudentNoticeState copyWith({
    String? selectedClass,
    String? section,
    DateTime? date,
    String? title,
    String? content,
    String? imagePath,
    String? documentPath,
    List<StudentNoticeRecipientModel>? allStudents,
    List<StudentNoticeRecipientModel>? filteredStudents,
    Set<String>? selectedStudentIds,
    String? searchQuery,
    bool? isLoadingStudents,
    bool? isSubmitting,
    bool? submitSuccess,
    String? error,
  }) {
    return AddStudentNoticeState(
      selectedClass: selectedClass ?? this.selectedClass,
      section: section ?? this.section,
      date: date ?? this.date,
      title: title ?? this.title,
      content: content ?? this.content,
      imagePath: imagePath ?? this.imagePath,
      documentPath: documentPath ?? this.documentPath,
      allStudents: allStudents ?? this.allStudents,
      filteredStudents: filteredStudents ?? this.filteredStudents,
      selectedStudentIds: selectedStudentIds ?? this.selectedStudentIds,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoadingStudents: isLoadingStudents ?? this.isLoadingStudents,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      submitSuccess: submitSuccess ?? this.submitSuccess,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    selectedClass,
    section,
    date,
    title,
    content,
    imagePath,
    documentPath,
    allStudents,
    filteredStudents,
    selectedStudentIds,
    searchQuery,
    isLoadingStudents,
    isSubmitting,
    submitSuccess,
    error,
  ];
}
