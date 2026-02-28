import 'package:equatable/equatable.dart';

enum HomeworkStatus { pending, submitted, late }

class HomeworkEntity extends Equatable {
  final String id;
  final String subject;
  final DateTime date;
  final String description;
  final String teacherName;
  final DateTime submissionDate;
  final HomeworkStatus status;

  const HomeworkEntity({
    required this.id,
    required this.subject,
    required this.date,
    required this.description,
    required this.teacherName,
    required this.submissionDate,
    required this.status,
  });

  @override
  List<Object?> get props => [
    id,
    subject,
    date,
    description,
    teacherName,
    submissionDate,
    status,
  ];

  // Mock data factory
  static List<HomeworkEntity> getMockData() {
    return [
      HomeworkEntity(
        id: '1',
        subject: 'SOCIAL SCIENCE',
        date: DateTime.now(),
        description:
            'Prepare for class test. Learn everything given in the class. Complete learning details as well of Chapter 10. Focus on the map section and historical timelines.',
        teacherName: 'RAJESHWARI KANOJIA',
        submissionDate: DateTime.now().add(const Duration(days: 2)),
        status: HomeworkStatus.pending,
      ),
      HomeworkEntity(
        id: '2',
        subject: 'MATHEMATICS',
        date: DateTime.now(),
        description:
            'Solve exercises 5.1 and 5.2 from the textbook. Practice quadratic equations.',
        teacherName: 'AMIT SHARMA',
        submissionDate: DateTime.now().add(const Duration(days: 1)),
        status: HomeworkStatus.pending,
      ),
      HomeworkEntity(
        id: '3',
        subject: 'SCIENCE',
        date: DateTime.now().subtract(const Duration(days: 1)),
        description:
            'Complete the lab report on acid-base titration. Draw neat diagrams.',
        teacherName: 'SARAH JENKINS',
        submissionDate: DateTime.now(),
        status: HomeworkStatus.submitted,
      ),
    ];
  }
}
