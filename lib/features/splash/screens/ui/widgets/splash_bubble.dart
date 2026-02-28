import 'package:flutter/material.dart';

class SplashBubble extends StatelessWidget {
  final double size;
  final Color color;
  final BoxShape shape;
  final bool isOutlined;
  final double strokeWidth;
  final BorderRadiusGeometry? borderRadius;

  const SplashBubble({
    super.key,
    required this.size,
    required this.color,
    this.shape = BoxShape.circle,
    this.isOutlined = false,
    this.strokeWidth = 2.0,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isOutlined ? Colors.transparent : color,
        shape: shape,
        borderRadius: shape == BoxShape.rectangle
            ? borderRadius ?? BorderRadius.zero
            : null,
        border: isOutlined
            ? Border.all(color: color, width: strokeWidth)
            : null,
      ),
    );
  }
}
