import 'package:flutter/material.dart';
import '../../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../../cubit/theme_cubit.dart';
import '../../../models/transport_student_model.dart';

class TransportAttendanceCard extends StatelessWidget {
  final TransportStudentModel student;
  final VoidCallback onStatusTap;

  const TransportAttendanceCard({
    super.key,
    required this.student,
    required this.onStatusTap,
  });

  @override
  Widget build(BuildContext context) {
    final isNotMarked = student.status == TransportAttendanceStatus.notMarked;

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
                          image: NetworkImage(
                            student.imageUrl.isNotEmpty
                                ? student.imageUrl
                                : 'https://via.placeholder.com/150',
                          ),
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
                          : context.colors.primary, // Dark Green
                      borderRadius: BorderRadius.circular(context.scale(8)),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Text(
                      student.rollNo,
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
                        : context.colors.iconDefault, // Dark Navy
                  ),
                ),
                SizedBox(height: context.scaleHeight(4)),
                Text(
                  student.rollNo,
                  style: TextStyle(
                    fontSize: context.scaleFont(12),
                    color: context.colors.textSecondary.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // 3. Status Button
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
    TransportAttendanceStatus status,
  ) {
    switch (status) {
      case TransportAttendanceStatus.boarded:
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.scale(12),
            vertical: context.scaleHeight(8),
          ),
          decoration: BoxDecoration(
            color: context.colors.primary, // Solid Green
            borderRadius: BorderRadius.circular(context.scale(16)),
          ),
          alignment: Alignment.center,
          child: Text(
            'Boarded',
            style: TextStyle(
              color: Colors.white,
              fontSize: context.scaleFont(12),
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      case TransportAttendanceStatus.notBoarded:
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.scale(12),
            vertical: context.scaleHeight(8),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(context.scale(16)),
            border: Border.all(color: Colors.red, width: 2),
          ),
          alignment: Alignment.center,
          child: Text(
            'Absent',
            style: TextStyle(
              color: Colors.red,
              fontSize: context.scaleFont(12),
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      case TransportAttendanceStatus.notMarked:
        return Container(
          width: context.scale(40),
          height: context.scale(40),
          decoration: BoxDecoration(
            color: context.colors.surfaceMedium, // Light grey
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
