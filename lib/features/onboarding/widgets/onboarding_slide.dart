import 'package:flutter/material.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import '../models/onboarding_item.dart';

class OnboardingSlide extends StatelessWidget {
  final OnboardingItem item;

  const OnboardingSlide({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.scale(24)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Graphic
          Container(
            width: context.scale(200),
            height: context.scale(200),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(24), // Outer white ring padding
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colors.primary, // Lighter blue inner circle
              ),
              child: Icon(
                item.icon,
                size: context.scale(80),
                color: Colors.white,
              ),
            ),
          ),

          SizedBox(height: context.scaleHeight(48)),

          // Title
          Text(
            item.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: context.scaleFont(28),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: context.scaleHeight(16)),

          // Description
          Text(
            item.description,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: context.scaleFont(16),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
