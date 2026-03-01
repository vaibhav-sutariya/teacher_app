import 'package:equatable/equatable.dart';

class EventModel extends Equatable {
  final String id;
  final String title;
  final String time;
  final String location;

  const EventModel({
    required this.id,
    required this.title,
    required this.time,
    required this.location,
  });

  @override
  List<Object?> get props => [id, title, time, location];
}

class AnnouncementModel extends Equatable {
  final String id;
  final String title;
  final String content;
  final DateTime date;

  const AnnouncementModel({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
  });

  @override
  List<Object?> get props => [id, title, content, date];
}

class LeaveModel extends Equatable {
  final String id;
  final String studentName;
  final String gradeSection;
  final String leaveType;

  const LeaveModel({
    required this.id,
    required this.studentName,
    required this.gradeSection,
    required this.leaveType,
  });

  @override
  List<Object?> get props => [id, studentName, gradeSection, leaveType];
}

class BirthdayModel extends Equatable {
  final String id;
  final String studentName;
  final String gradeSection;
  final DateTime date;

  const BirthdayModel({
    required this.id,
    required this.studentName,
    required this.gradeSection,
    required this.date,
  });

  @override
  List<Object?> get props => [id, studentName, gradeSection, date];
}

class HomeworkModel extends Equatable {
  final String id;
  final String subject;
  final String description;
  final DateTime dueDate;

  const HomeworkModel({
    required this.id,
    required this.subject,
    required this.description,
    required this.dueDate,
  });

  @override
  List<Object?> get props => [id, subject, description, dueDate];
}

class AttendanceStatsModel extends Equatable {
  final int markedSections;
  final int totalSections;
  final int totalStudents;
  final String markedStudents;
  final int present;
  final int absent;
  final int leave;
  final int percentage;

  const AttendanceStatsModel({
    required this.markedSections,
    required this.totalSections,
    this.totalStudents = 0,
    this.markedStudents = '-',
    this.present = 0,
    this.absent = 0,
    this.leave = 0,
    this.percentage = 0,
  });

  @override
  List<Object?> get props => [
    markedSections,
    totalSections,
    totalStudents,
    markedStudents,
    present,
    absent,
    leave,
    percentage,
  ];
}

class HomeworkStatsModel extends Equatable {
  final int updatedSections;
  final int totalSections;
  final DateTime? date;

  const HomeworkStatsModel({
    required this.updatedSections,
    required this.totalSections,
    this.date,
  });

  @override
  List<Object?> get props => [updatedSections, totalSections, date];
}
