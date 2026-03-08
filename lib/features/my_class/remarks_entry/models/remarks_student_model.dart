import 'package:equatable/equatable.dart';

class RemarksStudentModel extends Equatable {
  final String id;
  final String name;
  final String rollNo;
  final String className;

  const RemarksStudentModel({
    required this.id,
    required this.name,
    required this.rollNo,
    required this.className,
  });

  @override
  List<Object?> get props => [id, name, rollNo, className];
}
