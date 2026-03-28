import 'package:equatable/equatable.dart';
import '../../../transport_attendance/models/transport_student_model.dart';

class ViewTransportAttendanceDetailState extends Equatable {
  final bool isLoading;
  final List<TransportStudentModel> students;
  final String? errorMessage;

  const ViewTransportAttendanceDetailState({
    this.isLoading = false,
    this.students = const [],
    this.errorMessage,
  });

  ViewTransportAttendanceDetailState copyWith({
    bool? isLoading,
    List<TransportStudentModel>? students,
    String? errorMessage,
  }) {
    return ViewTransportAttendanceDetailState(
      isLoading: isLoading ?? this.isLoading,
      students: students ?? this.students,
      errorMessage: errorMessage,
    );
  }

  ViewTransportAttendanceDetailState clearError() {
    return ViewTransportAttendanceDetailState(
      isLoading: isLoading,
      students: students,
      errorMessage: null,
    );
  }

  @override
  List<Object?> get props => [isLoading, students, errorMessage];
}
