import 'package:flutter/material.dart';

enum AttachmentType { image, document }

class AssignmentModel {
  final String id;
  final DateTime date;
  final String subject;
  final String type; // e.g. "Chapter 5 - Algebra"
  final Color color;
  final String pdfUrl;
  
  // New fields for the expanded form
  final String? className;
  final String? sectionName;
  final String? lesson;
  final String? topic;
  final String? description;
  final AttachmentType? attachmentType;
  final bool isSmsEnabled;

  const AssignmentModel({
    required this.id,
    required this.date,
    required this.subject,
    required this.type,
    required this.color,
    required this.pdfUrl,
    this.className,
    this.sectionName,
    this.lesson,
    this.topic,
    this.description,
    this.attachmentType,
    this.isSmsEnabled = false,
  });

  // Mock data generator
  static List<AssignmentModel> getMockData() {
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
        className: '10th',
        sectionName: 'A',
        lesson: 'Algebra',
        topic: 'Linear Equations',
        description: 'Complete all exercises on page 45.',
      ),
      AssignmentModel(
        id: '2',
        date: DateTime(2025, 12, 15),
        subject: 'Science',
        type: 'PHYSICS LAB ASSIGNMENT',
        color: const Color(0xFF26A69A),
        pdfUrl: basePdfUrl,
        className: '9th',
        sectionName: 'B',
        lesson: 'Motion',
        topic: 'Newton\'s Laws',
        description: 'Prepare the lab report for experiment 3.',
      ),
      AssignmentModel(
        id: '3',
        date: DateTime(2025, 12, 10),
        subject: 'English',
        type: 'ESSAY WRITING ASSIGNMENT',
        color: const Color(0xFFFF9800),
        pdfUrl: basePdfUrl,
        className: '8th',
        sectionName: 'C',
        lesson: 'Grammar',
        topic: 'Tenses',
        description: 'Write an essay on your favorite book.',
      ),
    ];
  }
}
