import 'package:equatable/equatable.dart';
import '../../../../student_notice/models/student_notice_recipient_model.dart';
import '../../../models/gate_pass_model.dart';

class AddGatePassState extends Equatable {
  final String? selectedClass;
  final String? section;
  final DateTime date;
  final String? time;
  final GatePassType pickupType;
  final String reason;

  // Student selection
  final List<StudentNoticeRecipientModel> allStudents;
  final List<StudentNoticeRecipientModel> filteredStudents;
  final String searchQuery;
  final String? selectedStudentId; // Single selection for Gate Pass

  // Status flags
  final bool isLoadingStudents;
  final bool isSubmitting;
  final bool submitSuccess;
  final String? error;

  const AddGatePassState({
    this.selectedClass,
    this.section,
    required this.date,
    this.time,
    this.pickupType = GatePassType.student,
    this.reason = '',
    this.allStudents = const [],
    this.filteredStudents = const [],
    this.searchQuery = '',
    this.selectedStudentId,
    this.isLoadingStudents = false,
    this.isSubmitting = false,
    this.submitSuccess = false,
    this.error,
  });

  AddGatePassState copyWith({
    String? selectedClass,
    String? section,
    DateTime? date,
    String? time,
    GatePassType? pickupType,
    String? reason,
    List<StudentNoticeRecipientModel>? allStudents,
    List<StudentNoticeRecipientModel>? filteredStudents,
    String? searchQuery,
    String? selectedStudentId,
    bool? isLoadingStudents,
    bool? isSubmitting,
    bool? submitSuccess,
    String? error,
    bool clearError = false,
  }) {
    return AddGatePassState(
      selectedClass: selectedClass ?? this.selectedClass,
      section: section ?? this.section,
      date: date ?? this.date,
      time: time ?? this.time,
      pickupType: pickupType ?? this.pickupType,
      reason: reason ?? this.reason,
      allStudents: allStudents ?? this.allStudents,
      filteredStudents: filteredStudents ?? this.filteredStudents,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedStudentId: selectedStudentId ?? this.selectedStudentId,
      isLoadingStudents: isLoadingStudents ?? this.isLoadingStudents,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      submitSuccess: submitSuccess ?? this.submitSuccess,
      error: clearError ? null : (error ?? this.error),
    );
  }

  @override
  List<Object?> get props => [
    selectedClass,
    section,
    date,
    time,
    pickupType,
    reason,
    allStudents,
    filteredStudents,
    searchQuery,
    selectedStudentId,
    isLoadingStudents,
    isSubmitting,
    submitSuccess,
    error,
  ];
}
