import 'package:flutter/material.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';
import '../../../../models/remark_model.dart';
import 'package:intl/intl.dart';

class RemarkCard extends StatelessWidget {
  final RemarkModel remark;

  // Let's assume we map remark descriptions to mock student names for now
  // if the real model doesn't have student name. Ideally the model would
  // have studentName and studentImage URL.
  final String studentName;
  final String studentImage;

  const RemarkCard({
    super.key,
    required this.remark,
    required this.studentName,
    required this.studentImage,
  });

  @override
  Widget build(BuildContext context) {
    // Generate the ring gradient colors based on some hash or type to look dynamic
    final isNegative = remark.type == RemarkType.negative;
    final gradientColors = isNegative
        ? [const Color(0xFFE84258), const Color(0xFFFEE140)] // Pink to Yellow
        : [const Color(0xFF00C6FF), const Color(0xFF0072FF)]; // Cyan to Blue

    // Format Date
    String formattedDate = '';
    if (remark.date != null) {
      try {
        final parsed = DateTime.parse(remark.date!);
        formattedDate = DateFormat('dd-MMM-yyyy').format(parsed);
      } catch (_) {
        formattedDate = remark.date!;
      }
    } else {
      formattedDate = '25-Jun-2025'; // Fallback matching screenshot
    }

    final reasonText = remark.description ?? 'NOT BROUGHT SUBJECT BOOK';

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.scale(16),
        vertical: context.scaleHeight(10),
      ),
      child: Row(
        children: [
          // Detailed Avatar with Sweep Gradient Border
          Container(
            width: context.scale(48),
            height: context.scale(48),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(
                colors: gradientColors,
                startAngle: 0.0,
                endAngle: 3.14 * 2,
              ),
            ),
            padding: EdgeInsets.all(context.scale(2)), // Border width
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(context.scale(1)), // Inner white gap
              child: CircleAvatar(
                backgroundColor: context.colors.surface,
                backgroundImage: NetworkImage(studentImage),
              ),
            ),
          ),
          SizedBox(width: context.scale(16)),

          // Text Detail
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  studentName.toUpperCase(),
                  style: TextStyle(
                    fontSize: context.scaleFont(14),
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: context.scaleHeight(4)),
                Text(
                  reasonText.toUpperCase(),
                  style: TextStyle(
                    fontSize: context.scaleFont(12),
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: context.scale(8)),

          // Date Pill Container
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.scale(10),
              vertical: context.scaleHeight(4),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(context.scale(16)),
              border: Border.all(
                color: context.colors.secondary, // Teal border
                width: 1,
              ),
            ),
            child: Text(
              formattedDate,
              style: TextStyle(
                fontSize: context.scaleFont(10),
                fontWeight: FontWeight.bold,
                color: context.colors.secondary, // Teal text
              ),
            ),
          ),
        ],
      ),
    );
  }
}
