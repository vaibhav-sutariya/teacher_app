import 'package:equatable/equatable.dart';

class ClassSectionModel extends Equatable {
  final String sectionName;
  final int studentCount;
  final String category;

  const ClassSectionModel({
    required this.sectionName,
    required this.studentCount,
    required this.category,
  });

  @override
  List<Object?> get props => [sectionName, studentCount, category];
}
