import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class StaffNoticeModel extends Equatable {
  final String id;
  final String title;
  final String content;
  final DateTime date;
  final String postedBy;
  final Color? iconColor;

  const StaffNoticeModel({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.postedBy,
    this.iconColor,
  });

  @override
  List<Object?> get props => [id, title, content, date, postedBy, iconColor];

  static List<StaffNoticeModel> getMockNotices() {
    return [
      StaffNoticeModel(
        id: '1',
        title: 'Vigilance In Work',
        content: '''Respected Ma'am,
        
We are writing this to address a recent incident of negligence of work on 26th January.

This email is a positive note to you explaining the mistake that is rectified. We wish that you take due care and avoid errors oversight while scrutinizing the audio.

We appreciate your dedication towards work and take full responsibility for the mistakes and assure avoid such issues in the future.

--
Regards,
Human Resource Department''',
        date: DateTime(2024, 1, 30, 9, 49),
        postedBy: 'MADAN MOHAN SINGH',
        iconColor: const Color(0xFF333300), // Dark brown
      ),
      StaffNoticeModel(
        id: '2',
        title: 'Work Negligence - Memo',
        content: 'Please find attached the memo regarding work negligence.',
        date: DateTime(2024, 1, 30),
        postedBy: 'ADMIN',
        iconColor: const Color(0xFF8B4513), // Saddle brown
      ),
      StaffNoticeModel(
        id: '3',
        title: "Respected Ma'am,",
        content: 'General announcement for all staff members.',
        date: DateTime(2024, 1, 30),
        postedBy: 'PRINCIPAL',
        iconColor: const Color(0xFFE9967A), // Salmon
      ),
      StaffNoticeModel(
        id: '4',
        title: "Dear Jaydeep Sir & Dear Mamta Ma'am,",
        content: 'Personal holiday announcement.',
        date: DateTime(2024, 1, 20),
        postedBy: 'HOD',
        iconColor: const Color(0xFFAFEEEEE), // Pale blue
      ),
      StaffNoticeModel(
        id: '5',
        title: 'Denial of Leave Application',
        content: 'Your leave application has been denied due to upcoming exams.',
        date: DateTime(2024, 1, 19),
        postedBy: 'ADMIN',
        iconColor: const Color(0xFFFF00FF), // Magenta
      ),
    ];
  }
}
