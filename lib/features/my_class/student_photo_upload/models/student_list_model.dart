import 'package:equatable/equatable.dart';

class StudentListModel extends Equatable {
  final String id;
  final String name;
  final String className;
  final String rollNo;
  final bool isUploaded;
  final String? photoUrl;

  const StudentListModel({
    required this.id,
    required this.name,
    required this.className,
    required this.rollNo,
    required this.isUploaded,
    this.photoUrl,
  });

  @override
  List<Object?> get props => [id, name, className, rollNo, isUploaded, photoUrl];
}
