import 'package:equatable/equatable.dart';

class AdmissionStudentModel extends Equatable {
  final String rollNo;
  final String grNo;
  final String name;

  const AdmissionStudentModel({
    required this.rollNo,
    required this.grNo,
    required this.name,
  });

  @override
  List<Object?> get props => [rollNo, grNo, name];
}
