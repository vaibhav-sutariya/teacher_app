import 'package:equatable/equatable.dart';

class StudentModel extends Equatable {
  final String id;
  final String name;
  final String rollNo;
  final String className;
  final String section;
  final String profileImageUrl;

  const StudentModel({
    required this.id,
    required this.name,
    required this.rollNo,
    required this.className,
    required this.section,
    required this.profileImageUrl,
  });

  @override
  List<Object?> get props => [id, name, rollNo, className, section, profileImageUrl];
}
