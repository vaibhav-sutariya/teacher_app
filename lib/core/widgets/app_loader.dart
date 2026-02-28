import 'package:flutter/material.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

/// A simple and consistent loader widget used throughout the app.
class AppLoader extends StatelessWidget {
  final double size;
  final Color? color;
  final String? message;
  final bool center;
  final double strokeWidth;

  const AppLoader({
    super.key,
    this.size = 32,
    this.color,
    this.message,
    this.center = true,
    this.strokeWidth = 3,
  });

  @override
  Widget build(BuildContext context) {
    Widget loader = SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation(color ?? context.colors.primary),
      ),
    );

    if (message != null) {
      loader = Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          loader,
          const SizedBox(height: 12),
          Text(
            message!,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    if (center) {
      return Center(child: loader);
    }
    return loader;
  }
}
