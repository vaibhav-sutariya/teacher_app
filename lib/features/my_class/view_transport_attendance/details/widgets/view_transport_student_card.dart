import 'package:flutter/material.dart';
import '../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../cubit/theme_cubit.dart';
import '../../../transport_attendance/models/transport_student_model.dart';

class ViewTransportStudentCard extends StatelessWidget {
  final TransportStudentModel student;

  const ViewTransportStudentCard({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    // Determine status colors based on the student's attendance enum
    Color statusColor;
    IconData statusIcon;
    String statusText;

    switch (student.status) {
      case TransportAttendanceStatus.boarded:
        statusColor = context.colors.success;
        statusIcon = Icons.check_circle;
        statusText = 'BOARDED';
        break;
      case TransportAttendanceStatus.notBoarded:
        statusColor = context.colors.error;
        statusIcon = Icons.cancel;
        statusText = 'ABSENT';
        break;
      case TransportAttendanceStatus.notMarked:
        statusColor = Colors.orange;
        statusIcon = Icons.pending_actions;
        statusText = 'PENDING';
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border(
          bottom: BorderSide(color: context.colors.divider, width: 1),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: context.scale(16),
        vertical: context.scaleHeight(16),
      ),
      child: Row(
        children: [
          // Using grayscale for Pending, colored for Boarded/Absent
          student.status == TransportAttendanceStatus.notMarked
              ? ColorFiltered(
                  colorFilter: const ColorFilter.matrix([
                    0.2126,
                    0.7152,
                    0.0722,
                    0,
                    0,
                    0.2126,
                    0.7152,
                    0.0722,
                    0,
                    0,
                    0.2126,
                    0.7152,
                    0.0722,
                    0,
                    0,
                    0,
                    0,
                    0,
                    1,
                    0,
                  ]),
                  child: CircleAvatar(
                    radius: context.scale(24),
                    backgroundImage: NetworkImage(student.imageUrl),
                  ),
                )
              : CircleAvatar(
                  radius: context.scale(24),
                  backgroundImage: NetworkImage(student.imageUrl),
                ),
          SizedBox(width: context.scale(16)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student.name,
                  style: TextStyle(
                    fontSize: context.scaleFont(16),
                    fontWeight: FontWeight.bold,
                    color: context.colors.textPrimary,
                  ),
                ),
                SizedBox(height: context.scaleHeight(4)),
                Text(
                  'Roll No: ${student.rollNo}',
                  style: TextStyle(
                    fontSize: context.scaleFont(14),
                    color: context.colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.scale(12),
              vertical: context.scaleHeight(6),
            ),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(context.scale(20)),
              border: Border.all(color: statusColor.withValues(alpha: 0.5)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(statusIcon, size: context.scale(16), color: statusColor),
                SizedBox(width: context.scale(4)),
                Text(
                  statusText,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: context.scaleFont(12),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
