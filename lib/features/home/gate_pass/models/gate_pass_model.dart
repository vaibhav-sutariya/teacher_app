import 'package:flutter/material.dart';

enum GatePassType { student, parent }

enum GatePassStatus { approved, rejected, pending }

class GatePassModel {
  final String id;
  final String passId;
  final String reason;
  final DateTime date;
  final String formattedTime; // e.g., "10:00 AM - 12:00 PM" or just "10:00 AM"
  final GatePassType type;
  final GatePassStatus status;
  final String requestBy; // Name of student or parent

  const GatePassModel({
    required this.id,
    required this.passId,
    required this.reason,
    required this.date,
    required this.formattedTime,
    required this.type,
    required this.status,
    required this.requestBy,
  });

  Color get statusColor {
    switch (status) {
      case GatePassStatus.approved:
        return const Color(0xFFE8F5E9); // Light Green
      case GatePassStatus.pending:
        return const Color(0xFFE3F2FD); // Light Blue
      case GatePassStatus.rejected:
        return const Color(0xFFFFEBEE); // Light Red
    }
  }

  Color get statusTextColor {
    switch (status) {
      case GatePassStatus.approved:
        return const Color(0xFF2E7D32); // Dark Green
      case GatePassStatus.pending:
        return const Color(0xFF1565C0); // Dark Blue
      case GatePassStatus.rejected:
        return const Color(0xFFC62828); // Dark Red
    }
  }

  String get statusLabel {
    switch (status) {
      case GatePassStatus.approved:
        return 'APPROVED';
      case GatePassStatus.pending:
        return 'PENDING';
      case GatePassStatus.rejected:
        return 'REJECTED';
    }
  }

  // Mock Data
  static List<GatePassModel> getMockData() {
    return [
      GatePassModel(
        id: '1',
        passId: '#GP-1023',
        reason: 'Medical Checkup',
        date: DateTime.now(),
        formattedTime: '10:30 AM',
        type: GatePassType.student,
        status: GatePassStatus.pending,
        requestBy: 'Vaibhav Sutariya',
      ),
      GatePassModel(
        id: '2',
        passId: '#GP-0988',
        reason: 'Family Function',
        date: DateTime.now().subtract(const Duration(days: 2)),
        formattedTime: '01:00 PM',
        type: GatePassType.student,
        status: GatePassStatus.approved,
        requestBy: 'Vaibhav Sutariya',
      ),
      GatePassModel(
        id: '3',
        passId: '#GP-1100',
        reason: 'Parent Meeting',
        date: DateTime.now().add(const Duration(days: 1)),
        formattedTime: '09:00 AM',
        type: GatePassType.parent,
        status: GatePassStatus.pending,
        requestBy: 'John Doe (Father)',
      ),
      GatePassModel(
        id: '4',
        passId: '#GP-0850',
        reason: 'Urgent Document Submission',
        date: DateTime.now().subtract(const Duration(days: 5)),
        formattedTime: '11:00 AM',
        type: GatePassType.parent,
        status: GatePassStatus.approved,
        requestBy: 'Jane Doe (Mother)',
      ),
    ];
  }
}
