import 'package:equatable/equatable.dart';

/// Leave status enum
enum LeaveStatus { approved, pending, rejected }

/// Leave model - ready for API integration
class LeaveModel extends Equatable {
  final String id;
  final String? studentId;
  final DateTime startDate;
  final DateTime endDate;
  final String reason;
  final LeaveStatus status;
  final int days;
  final DateTime? appliedDate;
  final String? approvedBy;

  const LeaveModel({
    required this.id,
    this.studentId,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.status,
    required this.days,
    this.appliedDate,
    this.approvedBy,
  });

  @override
  List<Object?> get props => [
    id,
    studentId,
    startDate,
    endDate,
    reason,
    status,
    days,
    appliedDate,
    approvedBy,
  ];

  /// Static mock data for development
  static List<LeaveModel> getMockData() {
    final now = DateTime.now();
    return [
      // Current month leaves
      LeaveModel(
        id: '1',
        studentId: 'STU001',
        startDate: DateTime(now.year, now.month, 15),
        endDate: DateTime(now.year, now.month, 17),
        reason: 'Family Function',
        status: LeaveStatus.approved,
        days: 3,
        appliedDate: DateTime(now.year, now.month, 10),
        approvedBy: 'Jigna Panchal',
      ),
      LeaveModel(
        id: '2',
        studentId: 'STU001',
        startDate: DateTime(now.year, now.month, 5),
        endDate: DateTime(now.year, now.month, 5),
        reason: 'Medical Emergency',
        status: LeaveStatus.pending,
        days: 1,
        appliedDate: DateTime(now.year, now.month, 3),
      ),

      // Previous month leaves
      LeaveModel(
        id: '3',
        studentId: 'STU001',
        startDate: DateTime(now.year, now.month - 1, 20),
        endDate: DateTime(now.year, now.month - 1, 22),
        reason: 'Personal Work',
        status: LeaveStatus.approved,
        days: 3,
        appliedDate: DateTime(now.year, now.month - 1, 15),
        approvedBy: 'Jigna Panchal',
      ),
      LeaveModel(
        id: '4',
        studentId: 'STU001',
        startDate: DateTime(now.year, now.month - 1, 10),
        endDate: DateTime(now.year, now.month - 1, 10),
        reason: 'Sick Leave',
        status: LeaveStatus.rejected,
        days: 1,
        appliedDate: DateTime(now.year, now.month - 1, 8),
      ),

      // Next month leaves
      LeaveModel(
        id: '5',
        studentId: 'STU001',
        startDate: DateTime(now.year, now.month + 1, 5),
        endDate: DateTime(now.year, now.month + 1, 7),
        reason: 'Planned Vacation',
        status: LeaveStatus.pending,
        days: 3,
        appliedDate: DateTime(now.year, now.month, 25),
      ),
    ];
  }
}

/// Extension for helper methods
extension LeaveModelExtension on LeaveModel {
  /// Get status color
  int get statusColor {
    switch (status) {
      case LeaveStatus.approved:
        return 0xFF4CAF50;
      case LeaveStatus.pending:
        return 0xFFFFA726;
      case LeaveStatus.rejected:
        return 0xFFF44336;
    }
  }

  /// Get status display text
  String get statusText {
    switch (status) {
      case LeaveStatus.approved:
        return 'Approved';
      case LeaveStatus.pending:
        return 'Pending';
      case LeaveStatus.rejected:
        return 'Rejected';
    }
  }

  /// Get formatted date range
  String get dateRange {
    if (startDate.year == endDate.year &&
        startDate.month == endDate.month &&
        startDate.day == endDate.day) {
      return '${startDate.day} ${_getMonthName(startDate.month)} ${startDate.year}';
    }
    return '${startDate.day} ${_getMonthName(startDate.month)} ${startDate.year} - ${endDate.day} ${_getMonthName(endDate.month)} ${endDate.year}';
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}
