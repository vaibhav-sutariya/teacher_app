import 'package:flutter/material.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

class PortalHeader extends StatelessWidget {
  const PortalHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Logo Container
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: context.colors.textInverse.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            Icons.school_rounded,
            size: 40,
            color: context.colors.textInverse,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Elite Academy',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: context.colors.textInverse,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'PREMIUM PORTAL',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: context.colors.textInverse.withValues(alpha: 0.7),
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }
}
