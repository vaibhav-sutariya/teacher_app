import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../../core/helpers/extensions/responsive_extensions.dart';

class AttachmentUploadArea extends StatelessWidget {
  final VoidCallback onTap;
  final String? selectedFile;

  const AttachmentUploadArea({
    super.key,
    required this.onTap,
    this.selectedFile,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: selectedFile != null
          ? SizedBox(
              width: double.infinity,
              height: context.scaleHeight(160),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(context.scale(16)),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.file(File(selectedFile!), fit: BoxFit.cover),
                    Container(
                      color: Colors.black.withValues(
                        alpha: 0.1,
                      ), // Slight overlay for better visibility of potential replace action
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(context.scale(8)),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: context.scale(24),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : CustomPaint(
              painter: _DashedBorderPainter(
                color: const Color(0xFFC5CAE9), // Light Indigo
                strokeWidth: 2,
                gap: 5,
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: context.scaleHeight(24),
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F2F5), // Very light background
                  borderRadius: BorderRadius.circular(context.scale(16)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(context.scale(12)),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8EAF6), // Lighter Indigo
                        borderRadius: BorderRadius.circular(context.scale(30)),
                      ),
                      child: Icon(
                        Icons.cloud_upload_outlined,
                        size: context.scale(28),
                        color: const Color(0xFF1A237E), // Deep Blue
                      ),
                    ),
                    SizedBox(height: context.scaleHeight(12)),
                    Text(
                      'Select files to upload',
                      style: TextStyle(
                        fontSize: context.scaleFont(14),
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1A237E),
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: context.scaleHeight(4)),
                    Text(
                      'Maximum file size: 10MB',
                      style: TextStyle(
                        fontSize: context.scaleFont(12),
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;

  _DashedBorderPainter({
    required this.color,
    this.strokeWidth = 1.0,
    this.gap = 5.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Path path = Path();
    // Rounded rectangle path
    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(16),
      ),
    );

    final Path dashPath = Path();
    double distance = 0.0;

    for (final PathMetric metric in path.computeMetrics()) {
      while (distance < metric.length) {
        dashPath.addPath(
          metric.extractPath(distance, distance + gap),
          Offset.zero,
        );
        distance += gap * 2;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
