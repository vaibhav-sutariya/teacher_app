import 'package:equatable/equatable.dart';

class ClassworkAttachment extends Equatable {
  final String name;
  final String size;
  final String type; // e.g., 'pdf', 'image'
  final String url;

  const ClassworkAttachment({
    required this.name,
    required this.size,
    required this.type,
    required this.url,
  });

  @override
  List<Object?> get props => [name, size, type, url];
}

class ClassworkEntity extends Equatable {
  final String id;
  final String subject;
  final DateTime date;
  final String description;
  final List<ClassworkAttachment> attachments;

  const ClassworkEntity({
    required this.id,
    required this.subject,
    required this.date,
    required this.description,
    this.attachments = const [],
  });

  @override
  List<Object?> get props => [id, subject, date, description, attachments];

  // Mock data factory
  static List<ClassworkEntity> getMockData() {
    return [
      ClassworkEntity(
        id: '1',
        subject: 'ENGLISH GRAMMAR',
        date: DateTime.now(),
        description:
            'English Grammar Class Test on 10.02.26 Tuesday. Learn Lesson 14 and 15.\n\nKindly bring Class Test Notebook on the Test Day.',
      ),
      ClassworkEntity(
        id: '2',
        subject: 'SOCIAL SCIENCE',
        date: DateTime.now(),
        description: 'Learn the HOTS answer sent. of Chp-10.',
        attachments: const [
          ClassworkAttachment(
            name: 'HOTS_Chp10_Answers.pdf',
            size: '1.2MB',
            type: 'pdf',
            url: '',
          ),
        ],
      ),
      ClassworkEntity(
        id: '3',
        subject: 'MATHEMATICS',
        date: DateTime.now().subtract(const Duration(days: 1)),
        description:
            'Completed Exercise 4.3 in class. Solve Q5-Q10 in homework notebook.',
      ),
    ];
  }
}
