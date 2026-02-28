import 'package:flutter/material.dart';

enum NotificationType { attendance, leave, feeAlert, schoolEvent, general }

class NotificationModel {
  final String id;
  final String title;
  final String description;
  final DateTime time;
  final String? tag;
  final NotificationType type;
  final Map<String, dynamic>? data;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    this.tag,
    required this.type,
    this.data,
  });

  /// Helper to get the correct icon based on notification type
  IconData get icon {
    switch (type) {
      case NotificationType.attendance:
        return Icons.check_circle_outline_rounded;
      case NotificationType.leave:
        return Icons.calendar_today_rounded;
      case NotificationType.feeAlert:
        return Icons.warning_amber_rounded;
      case NotificationType.schoolEvent:
        return Icons.campaign_rounded;
      case NotificationType.general:
        return Icons.notifications_none_rounded;
    }
  }

  /// Groups notifications by a formatted date string for the UI headers
  static Map<String, List<NotificationModel>> groupByDate(
    List<NotificationModel> notifications,
  ) {
    final Map<String, List<NotificationModel>> grouped = {};

    for (var notification in notifications) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(const Duration(days: 1));
      final notifDate = DateTime(
        notification.time.year,
        notification.time.month,
        notification.time.day,
      );

      String dateHeader;
      if (notifDate == today) {
        dateHeader = 'TODAY, ${_formatShortDate(notifDate)}';
      } else if (notifDate == yesterday) {
        dateHeader = 'YESTERDAY, ${_formatShortDate(notifDate)}';
      } else {
        dateHeader = _formatShortDate(notifDate).toUpperCase();
      }

      if (!grouped.containsKey(dateHeader)) {
        grouped[dateHeader] = [];
      }
      grouped[dateHeader]!.add(notification);
    }

    return grouped;
  }

  static String _formatShortDate(DateTime date) {
    const months = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  // Mock data matching the design image exactly
  static List<NotificationModel> getMockData() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    return [
      NotificationModel(
        id: '1',
        title: 'Attendance',
        description:
            'Dear parents, Your ward **DHARMA** is **Present** today. Regular attendance helps in better learning and academic performance.',
        time: DateTime(today.year, today.month, today.day, 10, 30),
        tag: 'PRESENT',
        type: NotificationType.attendance,
      ),
      NotificationModel(
        id: '2',
        title: 'My Leave',
        description:
            'Your leave request for **25th March** has been **Approved**. Please ensure all pending assignments are submitted.',
        time: DateTime(today.year, today.month, today.day, 9, 15),
        tag: 'APPROVED',
        type: NotificationType.leave,
      ),
      NotificationModel(
        id: '3',
        title: 'Fee Alert',
        description:
            'The fee payment deadline for the current semester is approaching on **Feb 25th**. Please settle the dues to avoid late penalties.',
        time: DateTime(yesterday.year, yesterday.month, yesterday.day, 16, 45),
        tag: 'URGENT',
        type: NotificationType.feeAlert,
      ),
      NotificationModel(
        id: '4',
        title: 'School Event',
        description:
            'The annual Sports Day has been scheduled for next Friday. All students are requested to come in their respective house uniforms.',
        time: DateTime(yesterday.year, yesterday.month, yesterday.day, 11, 20),
        type: NotificationType.schoolEvent,
      ),
    ];
  }
}
