import 'package:flutter/material.dart';

import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../cubit/theme_cubit.dart';

/// Production-ready attendance summary widget with circular indicators
class AttendanceSummary extends StatelessWidget {
  final int totalDays;
  final int presentDays;
  final double overallPercentage;
  final String title;

  const AttendanceSummary({
    super.key,
    required this.totalDays,
    required this.presentDays,
    required this.overallPercentage,
    this.title = 'Attendance Summary',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.scale(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: context.scaleFont(16),
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              Container(
                width: context.scale(20),
                height: context.scale(20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.info_outline,
                  size: context.scale(14),
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          SizedBox(height: context.scaleHeight(16)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCircularIndicator(
                context,
                value: totalDays.toDouble(),
                total: totalDays.toDouble(),
                label: 'TOTAL DAYS',
                color: Theme.of(context).colorScheme.primary,
              ),
              _buildCircularIndicator(
                context,
                value: presentDays.toDouble(),
                total: totalDays.toDouble(),
                label: 'PRESENT',
                color: const Color(0xFF4CAF50),
              ),
              _buildCircularIndicator(
                context,
                value: overallPercentage,
                total: 100,
                label: 'OVERALL',
                color: context.colors.primary,
                isPercentage: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircularIndicator(
    BuildContext context, {
    required double value,
    required double total,
    required String label,
    required Color color,
    bool isPercentage = false,
  }) {
    final percentage = total > 0 ? (value / total) * 100 : 0.0;
    final strokeWidth = context.scale(8.0);
    final size = context.scale(80.0);

    return Column(
      children: [
        SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background circle
              SizedBox(
                width: size,
                height: size,
                child: CircularProgressIndicator(
                  value: 1.0,
                  strokeWidth: strokeWidth,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.grey[200]!,
                  ),
                ),
              ),
              // Progress circle
              SizedBox(
                width: size,
                height: size,
                child: CircularProgressIndicator(
                  value: (percentage / 100).clamp(0.0, 1.0),
                  strokeWidth: strokeWidth,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  backgroundColor: Colors.transparent,
                ),
              ),
              // Center text
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isPercentage
                        ? '${value.toInt()}%'
                        : value.toInt().toString(),
                    style: TextStyle(
                      fontSize: context.scaleFont(18),
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: context.scaleHeight(8)),
        Text(
          label,
          style: TextStyle(
            fontSize: context.scaleFont(11),
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
