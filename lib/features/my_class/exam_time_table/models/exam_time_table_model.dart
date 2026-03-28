import 'package:flutter/material.dart';

class ExamTimeTableModel {
  final String id;
  final DateTime date;
  final String examName;
  final String className;
  final Color color;
  final String pdfUrl;

  const ExamTimeTableModel({
    required this.id,
    required this.date,
    required this.examName,
    required this.className,
    required this.color,
    required this.pdfUrl,
  });

  // Mock data generator
  static List<ExamTimeTableModel> getMockData() {
    const basePdfUrl =
        'https://online.op.ac.nz/assets/LearningAdvice/99ab78acca/Weekly-study-timetable.pdf';

    return [
      ExamTimeTableModel(
        id: '1',
        date: DateTime(2025, 3, 15),
        examName: 'UNIT TEST-1 TIME TABLE',
        className: 'CLASS 1 TO 5',
        color: const Color(0xFF7E57C2),
        pdfUrl: basePdfUrl,
      ),
      ExamTimeTableModel(
        id: '2',
        date: DateTime(2025, 10, 20),
        examName: 'TERM-1 EXAM TIME TABLE',
        className: 'ALL CLASSES',
        color: const Color(0xFF26A69A),
        pdfUrl: basePdfUrl,
      ),
      ExamTimeTableModel(
        id: '3',
        date: DateTime(2026, 3, 10),
        examName: 'FINAL EXAM TIME TABLE',
        className: 'CLASS 1 TO 8',
        color: const Color(0xFFEF5350),
        pdfUrl: basePdfUrl,
      ),
    ];
  }
}
