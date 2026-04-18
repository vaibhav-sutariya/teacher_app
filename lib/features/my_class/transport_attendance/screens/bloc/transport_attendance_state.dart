import 'package:equatable/equatable.dart';
import '../../models/transport_student_model.dart';

class TransportAttendanceState extends Equatable {
  final String? selectedRoute;
  final DateTime date;

  final List<TransportStudentModel> allStudents;
  final List<TransportStudentModel> filteredStudents;
  final String searchQuery;

  final bool isLoading;
  final bool isSubmitting;
  final bool submitSuccess;
  final String? error;

  const TransportAttendanceState({
    this.selectedRoute,
    required this.date,
    this.allStudents = const [],
    this.filteredStudents = const [],
    this.searchQuery = '',
    this.isLoading = false,
    this.isSubmitting = false,
    this.submitSuccess = false,
    this.error,
  });

  factory TransportAttendanceState.initial() {
    return TransportAttendanceState(date: DateTime.now());
  }

  TransportAttendanceState copyWith({
    String? selectedRoute,
    DateTime? date,
    List<TransportStudentModel>? allStudents,
    List<TransportStudentModel>? filteredStudents,
    String? searchQuery,
    bool? isLoading,
    bool? isSubmitting,
    bool? submitSuccess,
    String? error,
  }) {
    return TransportAttendanceState(
      selectedRoute: selectedRoute ?? this.selectedRoute,
      date: date ?? this.date,
      allStudents: allStudents ?? this.allStudents,
      filteredStudents: filteredStudents ?? this.filteredStudents,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      submitSuccess: submitSuccess ?? this.submitSuccess,
      error:
          error, // Can be null to clear errors intentionally if we pass null explicitly?
      // Actually, error clearing usually requires a specialized null handler.
      // Let's just keep it simple or assume we don't clear it via this unless explicit.
    );
  }

  // Specific copy builder to clear error
  TransportAttendanceState clearError() {
    return TransportAttendanceState(
      selectedRoute: selectedRoute,
      date: date,
      allStudents: allStudents,
      filteredStudents: filteredStudents,
      searchQuery: searchQuery,
      isLoading: isLoading,
      isSubmitting: isSubmitting,
      submitSuccess: submitSuccess,
      error: null,
    );
  }

  @override
  List<Object?> get props => [
    selectedRoute,
    date,
    allStudents,
    filteredStudents,
    searchQuery,
    isLoading,
    isSubmitting,
    submitSuccess,
    error,
  ];
}
