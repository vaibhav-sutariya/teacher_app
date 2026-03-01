import 'package:flutter/material.dart';

import '../../../../../cubit/theme_cubit.dart';
import 'splash_bubble.dart';

class SplashBackground extends StatelessWidget {
  final Animation<double> scaleAnimation;
  final Animation<double> fadeAnimation;
  final Animation<double> breatheAnimation;
  final AnimationController breathingController;

  const SplashBackground({
    super.key,
    required this.scaleAnimation,
    required this.fadeAnimation,
    required this.breatheAnimation,
    required this.breathingController,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Top Right Large Yellow Bubble
        Positioned(
          top: -60,
          right: -80,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: SplashBubble(
              size: 280,
              color: context.colors.primary,
              shape: BoxShape.circle,
            ),
          ),
        ),

        // Top Right Blue Hollow Circle (near the yellow one)
        Positioned(
          top: 40,
          right: 30,
          child: FadeTransition(
            opacity: fadeAnimation,
            child: SplashBubble(
              size: 50,
              color: context.colors.secondary,
              shape: BoxShape.circle,
              isOutlined: true,
              strokeWidth: 3,
            ),
          ),
        ),

        // Top Right Small Solid Blue Dot
        Positioned(
          top: 15,
          right: 90,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: SplashBubble(
              size: 18,
              color: context.colors.secondary,
              shape: BoxShape.circle,
            ),
          ),
        ),

        // Bottom Left Large Yellow Bubble
        Positioned(
          bottom: -100,
          left: -80,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: SplashBubble(
              size: 380,
              color: context.colors.primary,
              shape: BoxShape.circle,
            ),
          ),
        ),

        // Purple hollow circle inside/near bottom yellow bubble
        Positioned(
          bottom: 120,
          left: 60,
          child: FadeTransition(
            opacity: fadeAnimation,
            child: SplashBubble(
              size: 45,
              color: context.colors.secondary,
              shape: BoxShape.circle,
              isOutlined: true,
              strokeWidth: 3,
            ),
          ),
        ),

        // Small blue square near bottom
        Positioned(
          bottom: 70,
          left: 170,
          child: RepaintBoundary(
            child: RotationTransition(
              turns: breathingController,
              child: FadeTransition(
                opacity: fadeAnimation,
                child: SplashBubble(
                  size: 25,
                  color: context.colors.secondary,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),

        // Top Curved Line (Arc)
        Positioned(
          top: 180,
          right: 50,
          child: FadeTransition(
            opacity: fadeAnimation,
            child: Transform.rotate(
              angle: 0.5,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border(
                    bottom: BorderSide(
                      color: context.colors.secondary.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        // Bottom Curved Line (Arc)
        Positioned(
          bottom: 150,
          left: 40,
          child: FadeTransition(
            opacity: fadeAnimation,
            child: Transform.rotate(
              angle: -0.5,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border(
                    top: BorderSide(
                      color: context.colors.secondary.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        // Scattered small shapes (bg pattern simulation) - simplified
        _buildScatteredDot(context, top: 100, left: 40),
        _buildScatteredDot(context, top: 250, left: 20, size: 8),
        _buildScatteredDot(
          context,
          top: 150,
          right: 150,
          color: context.colors.secondary.withValues(alpha: 0.2),
        ),
        _buildScatteredDot(context, bottom: 200, right: 30),
        _buildScatteredDot(context, bottom: 300, left: 100, size: 6),
      ],
    );
  }

  Widget _buildScatteredDot(
    BuildContext context, {
    double? top,
    double? bottom,
    double? left,
    double? right,
    double size = 10,
    Color? color,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: FadeTransition(
        opacity: fadeAnimation,
        child: SplashBubble(
          size: size,
          color: color ?? context.colors.secondary.withValues(alpha: 0.2),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
