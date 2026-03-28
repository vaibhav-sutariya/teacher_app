import 'package:equatable/equatable.dart';

class StudentNoticeModel extends Equatable {
  final String id;
  final String title;
  final String content;
  final DateTime date;
  final String className;
  // Additional fields as needed based on the response

  const StudentNoticeModel({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.className,
  });

  factory StudentNoticeModel.fromJson(Map<String, dynamic> json) {
    return StudentNoticeModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
      date: json['date'] != null
          ? DateTime.parse(json['date'])
          : DateTime.now(),
      className: json['className'] as String? ?? '',
    );
  }

  @override
  List<Object?> get props => [id, title, content, date, className];
}
