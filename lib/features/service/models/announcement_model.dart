import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnnouncementModel extends Equatable {
  final String id;
  final String title;
  final String content;
  final DateTime date;
  final String postedBy;
  final Color dateColor;

  const AnnouncementModel({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.postedBy,
    required this.dateColor,
  });

  String get day => DateFormat('dd').format(date);
  String get month => DateFormat('MMM').format(date);

  @override
  List<Object?> get props => [id, title, content, date, postedBy, dateColor];

  static List<AnnouncementModel> getMockData() {
    return [
      AnnouncementModel(
        id: '1',
        title: 'Vigilance In Work',
        content: 'All staff members are requested to maintain high vigilance during working hours. Please ensure all safety protocols are followed strictly.',
        date: DateTime(2026, 1, 30),
        postedBy: 'Administrator',
        dateColor: const Color(0xFFFFADAD), // Light coral
      ),
      AnnouncementModel(
        id: '2',
        title: 'Work Negligence - Memo',
        content: 'This is a general reminder regarding punctuality and task completion. Work negligence will be monitored and addressed accordingly.',
        date: DateTime(2026, 1, 30),
        postedBy: 'Principal',
        dateColor: const Color(0xFFE2FB16), // Lime yellow
      ),
      AnnouncementModel(
        id: '3',
        title: "Respected Ma'am,",
        content: 'Meeting scheduled for tomorrow at 10:00 AM in the conference hall to discuss the upcoming exam schedule.',
        date: DateTime(2026, 1, 30),
        postedBy: 'HOD',
        dateColor: const Color(0xFFFFC6FF), // Pink
      ),
      AnnouncementModel(
        id: '4',
        title: 'Dear Jaydeep Sir & Dear Mamta Ma\'am,',
        content: 'Coordination meeting for the annual sports event is finalized. Please bring the budget reports.',
        date: DateTime(2026, 1, 20),
        postedBy: 'Coordinator',
        dateColor: const Color(0xFF4BFF8B), // Bright green
      ),
      AnnouncementModel(
        id: '5',
        title: 'Dear Jaydeep Sir',
        content: 'Please review the student progress reports for Grade 10 by this Friday.',
        date: DateTime(2026, 1, 20),
        postedBy: 'Academic Head',
        dateColor: const Color(0xFF0011B0), // Dark blue
      ),
      AnnouncementModel(
        id: '6',
        title: 'Denial of Leave Application',
        content: 'Your leave application for upcoming Monday is denied due to the pre-scheduled inspection.',
        date: DateTime(2026, 1, 19),
        postedBy: 'Management',
        dateColor: const Color(0xFF865D36), // Brown
      ),
      AnnouncementModel(
        id: '7',
        title: "Dear Vrushali Ma'am,",
        content: 'The workshop on new teaching methodologies is mandatory for all teachers. Date: 25th Jan.',
        date: DateTime(2026, 1, 19),
        postedBy: 'Principal',
        dateColor: const Color(0xFF064522), // Dark green
      ),
      AnnouncementModel(
        id: '8',
        title: '16/01/2024 Memo',
        content: 'Final notice regarding the submission of internal assessment marks.',
        date: DateTime(2026, 1, 16),
        postedBy: 'Examination Cell',
        dateColor: const Color(0xFFEAB8C5), // Soft pink
      ),
    ];
  }
}
