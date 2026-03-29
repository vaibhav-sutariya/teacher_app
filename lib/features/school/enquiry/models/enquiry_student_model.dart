import 'package:equatable/equatable.dart';

class EnquiryStudentModel extends Equatable {
  final String name;
  final String fatherName;
  final String className;
  final String gender;
  final String status; // 'ADMITTED', 'ENQUIRY', 'REGISTRATION'
  final DateTime date;
  final String phone;

  const EnquiryStudentModel({
    required this.name,
    required this.fatherName,
    required this.className,
    required this.gender,
    required this.status,
    required this.date,
    required this.phone,
  });

  @override
  List<Object?> get props => [name, fatherName, className, gender, status, date, phone];
}
