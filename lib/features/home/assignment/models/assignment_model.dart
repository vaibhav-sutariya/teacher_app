import 'package:flutter/material.dart';

class AssignmentModel {
  final String id;
  final DateTime date;
  final String subject;
  final String type;
  final Color color;
  final String pdfUrl;

  const AssignmentModel({
    required this.id,
    required this.date,
    required this.subject,
    required this.type,
    required this.color,
    required this.pdfUrl,
  });

  // Mock data generator
  static List<AssignmentModel> getMockData() {
    // Using sample PDF URLs for testing
    const basePdfUrl =
        'https://online.op.ac.nz/assets/LearningAdvice/99ab78acca/Weekly-study-timetable.pdf';

    return [
      AssignmentModel(
        id: '1',
        date: DateTime(2025, 12, 20),
        subject: 'Mathematics',
        type: 'CHAPTER 5 - ALGEBRA ASSIGNMENT',
        color: const Color(0xFF5C6BC0),
        pdfUrl: basePdfUrl,
      ),
      AssignmentModel(
        id: '2',
        date: DateTime(2025, 12, 15),
        subject: 'Science',
        type: 'PHYSICS LAB ASSIGNMENT',
        color: const Color(0xFF26A69A),
        pdfUrl: basePdfUrl,
      ),
      AssignmentModel(
        id: '3',
        date: DateTime(2025, 12, 10),
        subject: 'English',
        type: 'ESSAY WRITING ASSIGNMENT',
        color: const Color(0xFFFF9800),
        pdfUrl: basePdfUrl,
      ),
      AssignmentModel(
        id: '4',
        date: DateTime(2025, 12, 5),
        subject: 'History',
        type: 'WORLD WAR II ASSIGNMENT',
        color: const Color(0xFFEC407A),
        pdfUrl: basePdfUrl,
      ),
      AssignmentModel(
        id: '5',
        date: DateTime(2025, 11, 30),
        subject: 'Computer Science',
        type: 'PROGRAMMING ASSIGNMENT',
        color: const Color(0xFF26C6DA),
        pdfUrl: basePdfUrl,
      ),
    ];
  }
}
