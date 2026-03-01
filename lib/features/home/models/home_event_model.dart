import 'package:flutter/material.dart';

enum EventType { sports, academic, holiday, other }

class CalendarEventModel {
  final String id;
  final String title;
  final DateTime date;
  final String startTime; // e.g., "08:30 AM"
  final String endTime; // e.g., "04:00 PM"
  final String description;
  final String location;
  final EventType type;

  const CalendarEventModel({
    required this.id,
    required this.title,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.description,
    required this.location,
    required this.type,
  });

  IconData get icon {
    switch (type) {
      case EventType.sports:
        return Icons.sports_basketball;
      case EventType.academic:
        return Icons.book;
      case EventType.holiday:
        return Icons.celebration;
      case EventType.other:
        return Icons.event;
    }
  }

  Color get color {
    switch (type) {
      case EventType.sports:
        return const Color(0xFFFF9800); // Orange
      case EventType.academic:
        return const Color(0xFF3F51B5); // Indigo
      case EventType.holiday:
        return const Color(0xFFE91E63); // Pink
      case EventType.other:
        return const Color(0xFF9C27B0); // Purple
    }
  }

  Color get backgroundColor {
    return color.withValues(alpha: 0.1);
  }

  // Mock Data
  static List<CalendarEventModel> getMockData() {
    final now = DateTime.now();
    return [
      CalendarEventModel(
        id: '1',
        title: 'Annual Sports Meet 2023',
        date: now,
        startTime: '08:30 AM',
        endTime: '04:00 PM',
        description:
            'Inter-house athletic competitions and award ceremony at the main ground.',
        location: 'Main Ground',
        type: EventType.sports,
      ),
      CalendarEventModel(
        id: '2',
        title: 'Final Science Project Submission',
        date: now,
        startTime: '09:00 AM',
        endTime: '12:00 PM',
        description:
            'Deadline for Grade 10 students to submit their research journals and models.',
        location: 'Science Lab, Block B',
        type: EventType.academic,
      ),
      CalendarEventModel(
        id: '3',
        title: 'Parent Teacher Meeting',
        date: now.add(const Duration(days: 2)),
        startTime: '10:00 AM',
        endTime: '01:00 PM',
        description: 'Monthly review of student progress.',
        location: 'Auditorium',
        type: EventType.other,
      ),
      CalendarEventModel(
        id: '4',
        title: 'Diwali Holiday',
        date: now.add(const Duration(days: 5)),
        startTime: 'All Day',
        endTime: '',
        description: 'School closed for Diwali festival.',
        location: '',
        type: EventType.holiday,
      ),
    ];
  }
}
