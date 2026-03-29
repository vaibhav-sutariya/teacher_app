import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import '../models/attendance_model.dart';

class AttendanceDetailTile extends StatelessWidget {
  final StaffAttendanceSummary summary;

  const AttendanceDetailTile({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final dateStr = DateFormat('dd').format(summary.date);
    final monthStr = DateFormat('MMM').format(summary.date);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: context.scaleHeight(12),
        horizontal: context.scale(16),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // 1. Circular Date Indicator
          _buildDateIndicator(context, dateStr, monthStr),

          SizedBox(width: context.scale(16)),

          // 2. Attendance Counts
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: context.scaleFont(15),
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    children: [
                      TextSpan(text: 'Absent : '),
                      TextSpan(
                        text: '${summary.absentCount}',
                        style: const TextStyle(color: Colors.red),
                      ),
                      const TextSpan(text: ' | '),
                      TextSpan(text: 'On Leave : '),
                      TextSpan(
                        text: '${summary.onLeaveCount}',
                        style: const TextStyle(color: Colors.orange),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.scaleHeight(4)),
                Text(
                  'Present : ${summary.presentCount}',
                  style: TextStyle(
                    fontSize: context.scaleFont(14),
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateIndicator(BuildContext context, String date, String month) {
    // Generate a semi-random but consistent color based on the date
    final colors = [
      Colors.teal.shade300,
      Colors.blue.shade300,
      Colors.purple.shade300,
      Colors.pink.shade300,
      Colors.amber.shade300,
      Colors.indigo.shade300,
    ];
    final color = colors[int.parse(date) % colors.length];

    return Container(
      width: context.scale(55),
      height: context.scale(55),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            date,
            style: TextStyle(
              fontSize: context.scaleFont(18),
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            month,
            style: TextStyle(
              fontSize: context.scaleFont(10),
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
