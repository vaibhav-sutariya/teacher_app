import 'package:flutter/material.dart';

class HolidayHwModel {
  final String id;
  final DateTime date;
  final String subject;
  final String type;
  final Color color;
  final String pdfUrl;

  const HolidayHwModel({
    required this.id,
    required this.date,
    required this.subject,
    required this.type,
    required this.color,
    required this.pdfUrl,
  });

  // Mock data generator
  static List<HolidayHwModel> getMockData() {
    // Using sample PDF URLs for testing
    const basePdfUrl =
        'https://online.op.ac.nz/assets/LearningAdvice/99ab78acca/Weekly-study-timetable.pdf';

    return [
      HolidayHwModel(
        id: '1',
        date: DateTime(2025, 12, 25),
        subject: 'Mathematics',
        type: 'WINTER HOLIDAY - ALGEBRA',
        color: const Color(0xFF5C6BC0),
        pdfUrl: basePdfUrl,
      ),
      HolidayHwModel(
        id: '2',
        date: DateTime(2025, 12, 20),
        subject: 'Science',
        type: 'WINTER BREAK - PHYSICS',
        color: const Color(0xFF26A69A),
        pdfUrl: basePdfUrl,
      ),
      HolidayHwModel(
        id: '3',
        date: DateTime(2025, 11, 10),
        subject: 'English',
        type: 'DIWALI HOLIDAY - READING',
        color: const Color(0xFFFF9800),
        pdfUrl: basePdfUrl,
      ),
      HolidayHwModel(
        id: '4',
        date: DateTime(2025, 10, 2),
        subject: 'History',
        type: 'GANDHI JAYANTI - PROJECT',
        color: const Color(0xFFEC407A),
        pdfUrl: basePdfUrl,
      ),
      HolidayHwModel(
        id: '5',
        date: DateTime(2025, 8, 15),
        subject: 'Computer Science',
        type: 'INDEPENDENCE DAY - CODING',
        color: const Color(0xFF26C6DA),
        pdfUrl: basePdfUrl,
      ),
    ];
  }
}
