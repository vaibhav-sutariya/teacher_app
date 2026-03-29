import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

class AttendanceDateCircle extends StatelessWidget {
  final DateTime date;
  final double percentage;

  const AttendanceDateCircle({
    super.key,
    required this.date,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Circular Progress Ring
            SizedBox(
              width: context.scale(160),
              height: context.scale(160),
              child: CustomPaint(
                painter: _CircleProgressPainter(
                  percentage: percentage,
                  primaryColor: context.colors.primary,
                ),
              ),
            ),
            // Date Display
            Container(
              width: context.scale(130),
              height: context.scale(130),
              decoration: BoxDecoration(
                color: context.colors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('dd').format(date),
                    style: TextStyle(
                      fontSize: context.scaleFont(38),
                      fontWeight: FontWeight.bold,
                      color: context.colors.primary,
                    ),
                  ),
                  Text(
                    DateFormat('MMM').format(date).toUpperCase(),
                    style: TextStyle(
                      fontSize: context.scaleFont(18),
                      fontWeight: FontWeight.w600,
                      color: context.colors.primary.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: context.scaleHeight(15)),
        Text(
          'Total Presence: ${percentage.toStringAsFixed(1)}%',
          style: TextStyle(
            fontSize: context.scaleFont(14),
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}

class _CircleProgressPainter extends CustomPainter {
  final double percentage;
  final Color primaryColor;

  _CircleProgressPainter({required this.percentage, required this.primaryColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final strokeWidth = size.width * 0.08;

    // Background track
    final trackPaint = Paint()
      ..color = Colors.grey.shade100
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius - strokeWidth / 2, trackPaint);

    // Progress arc
    final progressPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * pi * (percentage / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      -pi / 2, // Start at 12 o'clock
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class AttendanceMetricCard extends StatelessWidget {
  final String label;
  final int count;
  final Color color;
  final IconData icon;

  const AttendanceMetricCard({
    super.key,
    required this.label,
    required this.count,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.scale(12)),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(context.scale(12)),
        border: Border.all(color: color.withValues(alpha: 0.1), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(context.scale(8)),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: context.scale(18)),
          ),
          SizedBox(width: context.scale(12)),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: context.scaleFont(14),
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800,
              ),
            ),
          ),
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: context.scaleFont(18),
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
