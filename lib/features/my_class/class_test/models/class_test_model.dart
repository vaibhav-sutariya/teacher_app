import 'package:flutter/material.dart';

class ClassTestModel {
  final String id;
  final DateTime date;
  final String subject;
  final String type;
  final Color color;
  final String pdfUrl;

  const ClassTestModel({
    required this.id,
    required this.date,
    required this.subject,
    required this.type,
    required this.color,
    required this.pdfUrl,
  });

  // Mock data generator
  static List<ClassTestModel> getMockData() {
    // Using sample PDF URLs for testing
    const basePdfUrl =
        'https://online.op.ac.nz/assets/LearningAdvice/99ab78acca/Weekly-study-timetable.pdf';

    return [
      ClassTestModel(
        id: '1',
        date: DateTime(2025, 12, 5),
        subject: 'Mathematics',
        type: 'CHAPTER 1 - NUMBERS TEST',
        color: const Color(0xFF5C6BC0),
        pdfUrl: basePdfUrl,
      ),
      ClassTestModel(
        id: '2',
        date: DateTime(2025, 12, 8),
        subject: 'Science',
        type: 'UNIT 2 - FORCES TEST',
        color: const Color(0xFF26A69A),
        pdfUrl: basePdfUrl,
      ),
      ClassTestModel(
        id: '3',
        date: DateTime(2025, 12, 12),
        subject: 'English',
        type: 'GRAMMAR - NOUNS TEST',
        color: const Color(0xFFFF9800),
        pdfUrl: basePdfUrl,
      ),
      ClassTestModel(
        id: '4',
        date: DateTime(2025, 12, 15),
        subject: 'History',
        type: 'ANCIENT CIVILIZATIONS TEST',
        color: const Color(0xFFEC407A),
        pdfUrl: basePdfUrl,
      ),
      ClassTestModel(
        id: '5',
        date: DateTime(2025, 12, 18),
        subject: 'Computer Science',
        type: 'PYTHON BASICS TEST',
        color: const Color(0xFF26C6DA),
        pdfUrl: basePdfUrl,
      ),
    ];
  }
}
