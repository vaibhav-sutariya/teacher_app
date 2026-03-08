import 'package:flutter/material.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../cubit/theme_cubit.dart';
import '../models/student_attendance_model.dart';

class StudentAttendanceCard extends StatelessWidget {
  final StudentAttendanceModel student;
  final VoidCallback onStatusTap;
  final VoidCallback onSpecialStatusTap;

  const StudentAttendanceCard({
    super.key,
    required this.student,
    required this.onStatusTap,
    required this.onSpecialStatusTap,
  });

  @override
  Widget build(BuildContext context) {
    final isNotMarked = student.status == AttendanceStatusEnum.notMarked;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.scale(16),
        vertical: context.scaleHeight(6),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: context.scale(12),
        vertical: context.scaleHeight(12),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.scale(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // 1. Avatar with Badge
          SizedBox(
            width: context.scale(56),
            height: context.scale(56),
            child: Stack(
              children: [
                Positioned.fill(
                  child: ColorFiltered(
                    colorFilter: isNotMarked
                        ? const ColorFilter.matrix([
                            // Grayscale matrix
                            0.2126, 0.7152, 0.0722, 0, 0,
                            0.2126, 0.7152, 0.0722, 0, 0,
                            0.2126, 0.7152, 0.0722, 0, 0,
                            0, 0, 0, 1, 0,
                          ])
                        : const ColorFilter.mode(
                            Colors.transparent,
                            BlendMode.multiply,
                          ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200, // Fallback
                        borderRadius: BorderRadius.circular(context.scale(12)),
                        image: DecorationImage(
                          image: NetworkImage(student.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -2,
                  right: -4,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.scale(6),
                      vertical: context.scaleHeight(2),
                    ),
                    decoration: BoxDecoration(
                      color: isNotMarked
                          ? context.colors.textSecondary.withValues(alpha: 0.5)
                          : const Color(0xFF006D44), // Dark Green
                      borderRadius: BorderRadius.circular(context.scale(8)),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Text(
                      student.rollNumber.toString().padLeft(2, '0'),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: context.scaleFont(10),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: context.scale(16)),

          // 2. Name and Roll No
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student.name,
                  style: TextStyle(
                    fontSize: context.scaleFont(16),
                    fontWeight: FontWeight.bold,
                    color: isNotMarked
                        ? context.colors.textSecondary
                        : const Color(0xFF233240), // Dark Navy
                  ),
                ),
                SizedBox(height: context.scaleHeight(4)),
                Text(
                  student.rollNoString,
                  style: TextStyle(
                    fontSize: context.scaleFont(12),
                    color: context.colors.textSecondary.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // 3. Special Status Dropdown
          InkWell(
            onTap: onSpecialStatusTap,
            borderRadius: BorderRadius.circular(context.scale(8)),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.scale(8),
                vertical: context.scaleHeight(4),
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F5F7), // Light GrayBg
                borderRadius: BorderRadius.circular(context.scale(6)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    student.specialStatus,
                    style: TextStyle(
                      fontSize: context.scaleFont(12),
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF233240),
                    ),
                  ),
                  SizedBox(width: context.scale(2)),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: context.scale(16),
                    color: context.colors.primary,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: context.scale(12)),

          // 4. Main Status Button
          InkWell(
            onTap: onStatusTap,
            borderRadius: BorderRadius.circular(context.scale(24)),
            child: _buildStatusIndicator(context, student.status),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator(
    BuildContext context,
    AttendanceStatusEnum status,
  ) {
    switch (status) {
      case AttendanceStatusEnum.present:
        return Container(
          width: context.scale(40),
          height: context.scale(40),
          decoration: BoxDecoration(
            color: const Color(0xFF006D44), // Solid Green
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            'P',
            style: TextStyle(
              color: Colors.white,
              fontSize: context.scaleFont(16),
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      case AttendanceStatusEnum.absent:
        return Container(
          width: context.scale(40),
          height: context.scale(40),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.red, width: 2),
          ),
          alignment: Alignment.center,
          child: Text(
            'A',
            style: TextStyle(
              color: Colors.red,
              fontSize: context.scaleFont(16),
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      case AttendanceStatusEnum.notMarked:
        return Container(
          width: context.scale(40),
          height: context.scale(40),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F5F7), // Light grey
            shape: BoxShape.circle,
            border: Border.all(
              color: context.colors.textSecondary.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            '?',
            style: TextStyle(
              color: context.colors.textSecondary.withValues(alpha: 0.6),
              fontSize: context.scaleFont(16),
              fontWeight: FontWeight.bold,
            ),
          ),
        );
    }
  }
}
