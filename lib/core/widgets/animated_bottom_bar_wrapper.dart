import 'package:flutter/material.dart';

import '../animations/animation_constants.dart';

/// Animated wrapper for bottom navigation bar with slide animations
/// Uses AnimatedSlide for smooth, performant animations
class AnimatedBottomBarWrapper extends StatelessWidget {
  final Widget child;
  final bool isVisible;
  final Duration duration;
  final Curve curve;

  const AnimatedBottomBarWrapper({
    super.key,
    required this.child,
    required this.isVisible,
    this.duration = AppAnimations.medium,
    this.curve = AppAnimations.defaultCurve,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      duration: duration,
      curve: curve,
      offset: isVisible ? Offset.zero : const Offset(0, 1.5),
      child: AnimatedOpacity(
        duration: duration,
        curve: curve,
        opacity: isVisible ? 1.0 : 0.0,
        child: child,
      ),
    );
  }
}
