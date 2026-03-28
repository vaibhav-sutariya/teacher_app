import 'package:equatable/equatable.dart';

class ParentListModel extends Equatable {
  final String id;
  final String parentName;
  final String studentName;
  final String className;
  final String rollNo;
  final bool isUploaded;
  final String? photoUrl;

  const ParentListModel({
    required this.id,
    required this.parentName,
    required this.studentName,
    required this.className,
    required this.rollNo,
    required this.isUploaded,
    this.photoUrl,
  });

  @override
  List<Object?> get props => [
        id,
        parentName,
        studentName,
        className,
        rollNo,
        isUploaded,
        photoUrl,
      ];
}
