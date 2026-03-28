import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum CalendarEventType { holiday, event, exam, other }

class CalendarEventModel extends Equatable {
  final DateTime date;
  final String title;
  final String targetClass;
  final CalendarEventType type;
  final bool isSpecialHighlight;
  final String? description;

  const CalendarEventModel({
    required this.date,
    required this.title,
    required this.targetClass,
    required this.type,
    this.isSpecialHighlight = false,
    this.description,
  });

  Color get typeColor {
    switch (type) {
      case CalendarEventType.holiday:
        return const Color(0xFFF44336); // Red
      case CalendarEventType.event:
        return const Color(0xFF4CAF50); // Green
      case CalendarEventType.exam:
        return const Color(0xFF2196F3); // Blue
      case CalendarEventType.other:
        return Colors.orange;
    }
  }

  @override
  List<Object?> get props => [
    date,
    title,
    targetClass,
    type,
    isSpecialHighlight,
    description,
  ];
}
