import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../core/widgets/attendance_calendar.dart';

/// Modern, user-friendly widget to display selected date's attendance status
/// Features gradient backgrounds, smooth animations, and intuitive design
class SelectedDateStatusCard extends StatelessWidget {
  final DateTime selectedDate;
  final AttendanceStatus? status;

  const SelectedDateStatusCard({
    super.key,
    required this.selectedDate,
    this.status,
  });

  String _getStatusText() {
    switch (status) {
      case AttendanceStatus.present:
        return 'Present';
      case AttendanceStatus.absent:
        return 'Absent';
      case AttendanceStatus.holiday:
        return 'Holiday';
      case AttendanceStatus.notMarked:
      case null:
        return 'Not Marked';
    }
  }

  String _getStatusSubtext() {
    switch (status) {
      case AttendanceStatus.present:
        return 'You were marked present';
      case AttendanceStatus.absent:
        return 'You were marked absent';
      case AttendanceStatus.holiday:
        return 'This was a holiday';
      case AttendanceStatus.notMarked:
      case null:
        return 'No attendance recorded';
    }
  }

  Color _getStatusColor() {
    switch (status) {
      case AttendanceStatus.present:
        return const Color(0xFF4CAF50); // Green
      case AttendanceStatus.absent:
        return const Color(0xFFF44336); // Red
      case AttendanceStatus.holiday:
        return const Color(0xFFFF9800); // Orange
      case AttendanceStatus.notMarked:
      case null:
        return Colors.grey;
    }
  }

  List<Color> _getStatusGradient() {
    switch (status) {
      case AttendanceStatus.present:
        return [
          const Color(0xFF4CAF50).withOpacity(0.15),
          const Color(0xFF66BB6A).withOpacity(0.08),
        ];
      case AttendanceStatus.absent:
        return [
          const Color(0xFFF44336).withOpacity(0.15),
          const Color(0xFFE57373).withOpacity(0.08),
        ];
      case AttendanceStatus.holiday:
        return [
          const Color(0xFFFF9800).withOpacity(0.15),
          const Color(0xFFFFB74D).withOpacity(0.08),
        ];
      case AttendanceStatus.notMarked:
      case null:
        return [
          Colors.grey.withOpacity(0.1),
          Colors.grey.withOpacity(0.05),
        ];
    }
  }

  IconData _getStatusIcon() {
    switch (status) {
      case AttendanceStatus.present:
        return Icons.check_circle_rounded;
      case AttendanceStatus.absent:
        return Icons.cancel_rounded;
      case AttendanceStatus.holiday:
        return Icons.beach_access_rounded;
      case AttendanceStatus.notMarked:
      case null:
        return Icons.help_outline_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('EEEE');
    final dayFormat = DateFormat('MMM d, yyyy');
    final dayName = dateFormat.format(selectedDate);
    final formattedDate = dayFormat.format(selectedDate);
    final statusText = _getStatusText();
    final statusSubtext = _getStatusSubtext();
    final statusColor = _getStatusColor();
    final statusIcon = _getStatusIcon();
    final gradientColors = _getStatusGradient();
    final borderRadius = BorderRadius.circular(context.scale(20));

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.scale(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors,
          ),
          boxShadow: [
            BoxShadow(
              color: statusColor.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: borderRadius,
            ),
            child: Padding(
              padding: EdgeInsets.all(context.scale(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row with day name and status badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Day name and date
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dayName,
                              style: TextStyle(
                                fontSize: context.scaleFont(12),
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(height: context.scaleHeight(4)),
                            Text(
                              formattedDate,
                              style: TextStyle(
                                fontSize: context.scaleFont(16),
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Status badge with icon
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.scale(14),
                          vertical: context.scale(8),
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              statusColor,
                              statusColor.withOpacity(0.8),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(context.scale(20)),
                          boxShadow: [
                            BoxShadow(
                              color: statusColor.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              statusIcon,
                              color: Colors.white,
                              size: context.scale(16),
                            ),
                            SizedBox(width: context.scale(6)),
                            Text(
                              statusText.toUpperCase(),
                              style: TextStyle(
                                fontSize: context.scaleFont(11),
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.scaleHeight(16)),
                  // Status indicator with icon and description
                  Container(
                    padding: EdgeInsets.all(context.scale(16)),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(context.scale(16)),
                      border: Border.all(
                        color: statusColor.withOpacity(0.2),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        // Large status icon
                        Container(
                          width: context.scale(48),
                          height: context.scale(48),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                statusColor,
                                statusColor.withOpacity(0.7),
                              ],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: statusColor.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            statusIcon,
                            color: Colors.white,
                            size: context.scale(24),
                          ),
                        ),
                        SizedBox(width: context.scale(14)),
                        // Status description
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                statusText,
                                style: TextStyle(
                                  fontSize: context.scaleFont(16),
                                  fontWeight: FontWeight.bold,
                                  color: statusColor,
                                ),
                              ),
                              SizedBox(height: context.scaleHeight(2)),
                              Text(
                                statusSubtext,
                                style: TextStyle(
                                  fontSize: context.scaleFont(13),
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
