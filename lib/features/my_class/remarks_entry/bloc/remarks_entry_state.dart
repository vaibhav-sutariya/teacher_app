import 'package:equatable/equatable.dart';
import '../models/remarks_student_model.dart';

class RemarksEntryState extends Equatable {
  // Form Details
  final String? selectedClass;
  final String? section;
  final DateTime date;
  final String? category;
  final String? remarkName;
  final String? remarkType;
  final String note;

  // Student Selection Details
  final List<RemarksStudentModel> allStudents;
  final List<RemarksStudentModel> filteredStudents;
  final Set<String> selectedStudentIds;
  final String searchQuery;

  // Status
  final bool isLoadingStudents;
  final bool isSubmitting;
  final bool submitSuccess;

  const RemarksEntryState({
    this.selectedClass,
    this.section,
    required this.date,
    this.category,
    this.remarkName,
    this.remarkType,
    this.note = '',
    this.allStudents = const [],
    this.filteredStudents = const [],
    this.selectedStudentIds = const {},
    this.searchQuery = '',
    this.isLoadingStudents = false,
    this.isSubmitting = false,
    this.submitSuccess = false,
  });

  factory RemarksEntryState.initial() =>
      RemarksEntryState(date: DateTime.now());

  RemarksEntryState copyWith({
    String? selectedClass,
    String? section,
    DateTime? date,
    String? category,
    String? remarkName,
    String? remarkType,
    String? note,
    List<RemarksStudentModel>? allStudents,
    List<RemarksStudentModel>? filteredStudents,
    Set<String>? selectedStudentIds,
    String? searchQuery,
    bool? isLoadingStudents,
    bool? isSubmitting,
    bool? submitSuccess,
  }) {
    return RemarksEntryState(
      selectedClass: selectedClass ?? this.selectedClass,
      section: section ?? this.section,
      date: date ?? this.date,
      category: category ?? this.category,
      remarkName: remarkName ?? this.remarkName,
      remarkType: remarkType ?? this.remarkType,
      note: note ?? this.note,
      allStudents: allStudents ?? this.allStudents,
      filteredStudents: filteredStudents ?? this.filteredStudents,
      selectedStudentIds: selectedStudentIds ?? this.selectedStudentIds,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoadingStudents: isLoadingStudents ?? this.isLoadingStudents,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      submitSuccess: submitSuccess ?? this.submitSuccess,
    );
  }

  @override
  List<Object?> get props => [
    selectedClass,
    section,
    date,
    category,
    remarkName,
    remarkType,
    note,
    allStudents,
    filteredStudents,
    selectedStudentIds,
    searchQuery,
    isLoadingStudents,
    isSubmitting,
    submitSuccess,
  ];
}
