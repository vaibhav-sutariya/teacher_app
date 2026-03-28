part of 'admission_student_list_bloc.dart';

enum AdmissionStudentListStatus { initial, loading, loaded, error }

class AdmissionStudentListState extends Equatable {
  final AdmissionStudentListStatus status;
  final List<AdmissionStudentModel> students;
  final String? className;
  final DateTime? date;
  final String? errorMessage;

  const AdmissionStudentListState({
    this.status = AdmissionStudentListStatus.initial,
    this.students = const [],
    this.className,
    this.date,
    this.errorMessage,
  });

  AdmissionStudentListState copyWith({
    AdmissionStudentListStatus? status,
    List<AdmissionStudentModel>? students,
    String? className,
    DateTime? date,
    String? errorMessage,
  }) {
    return AdmissionStudentListState(
      status: status ?? this.status,
      students: students ?? this.students,
      className: className ?? this.className,
      date: date ?? this.date,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        students,
        className,
        date,
        errorMessage,
      ];
}
