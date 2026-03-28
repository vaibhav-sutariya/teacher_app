import 'package:equatable/equatable.dart';

class EmployeeListModel extends Equatable {
  final String id;
  final String name;
  final String designation;
  final bool isUploaded;
  final String? photoUrl;

  const EmployeeListModel({
    required this.id,
    required this.name,
    required this.designation,
    required this.isUploaded,
    this.photoUrl,
  });

  @override
  List<Object?> get props => [id, name, designation, isUploaded, photoUrl];
}
