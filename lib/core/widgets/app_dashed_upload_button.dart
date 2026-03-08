import 'dart:ui';
import 'package:flutter/material.dart';
import '../helpers/extensions/responsive_extensions.dart';

class AppDashedUploadButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const AppDashedUploadButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(context.scale(12)),
      child: CustomPaint(
        painter: _DashBorderPainter(
          color: const Color(0xFFA7D5A4), // Light Green Border
          strokeWidth: 1.5,
          gap: 4.0,
          radius: context.scale(12),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: context.scaleHeight(14)),
          decoration: BoxDecoration(
            color: const Color(0xFFF3FAF4), // Very Light Green bg
            borderRadius: BorderRadius.circular(context.scale(12)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: const Color(0xFF006D44),
                size: context.scale(20),
              ),
              SizedBox(width: context.scale(8)),
              Text(
                label,
                style: TextStyle(
                  fontSize: context.scaleFont(14),
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF006D44),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double radius;

  _DashBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.gap,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final RRect rrect = RRect.fromLTRBR(
      0,
      0,
      size.width,
      size.height,
      Radius.circular(radius),
    );

    final Path path = Path()..addRRect(rrect);
    final PathMetrics pathMetrics = path.computeMetrics();

    for (PathMetric pathMetric in pathMetrics) {
      double distance = 0.0;
      bool draw = true;
      while (distance < pathMetric.length) {
        final double segmentLength = draw ? gap * 2 : gap;
        if (draw) {
          final Path extractPath = pathMetric.extractPath(
            distance,
            distance + segmentLength,
          );
          canvas.drawPath(extractPath, paint);
        }
        distance += segmentLength;
        draw = !draw;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
