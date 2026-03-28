import 'package:equatable/equatable.dart';

class StudentNoticeRecipientModel extends Equatable {
  final String id;
  final String name;
  final String rollNo;
  final String className;

  const StudentNoticeRecipientModel({
    required this.id,
    required this.name,
    required this.rollNo,
    required this.className,
  });

  factory StudentNoticeRecipientModel.fromJson(Map<String, dynamic> json) {
    return StudentNoticeRecipientModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Unknown',
      rollNo: json['rollNo'] as String? ?? 'N/A',
      className: json['className'] as String? ?? '',
    );
  }

  @override
  List<Object?> get props => [id, name, rollNo, className];
}
