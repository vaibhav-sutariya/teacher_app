part of 'admission_student_list_bloc.dart';

abstract class AdmissionStudentListEvent extends Equatable {
  const AdmissionStudentListEvent();

  @override
  List<Object?> get props => [];
}

class LoadClassAdmissions extends AdmissionStudentListEvent {
  final String className;
  final DateTime date;
  const LoadClassAdmissions({required this.className, required this.date});

  @override
  List<Object?> get props => [className, date];
}
