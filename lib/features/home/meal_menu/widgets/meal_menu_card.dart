import 'package:flutter/material.dart';

import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../models/meal_menu_model.dart';

class MealMenuCard extends StatelessWidget {
  final MealMenuEntity meal;

  const MealMenuCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.scaleHeight(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.scale(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04), // Subtle shadow
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(context.scale(16)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Content: Header + Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Meal Type Header with Icon
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(context.scale(8)),
                        decoration: BoxDecoration(
                          color: _getMealColor(
                            context,
                            meal.mealType,
                          ).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(context.scale(8)),
                        ),
                        child: Icon(
                          _getMealIcon(meal.mealType),
                          color: _getMealColor(context, meal.mealType),
                          size: context.scale(20),
                        ),
                      ),
                      SizedBox(width: context.scale(12)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            meal.mealType.label,
                            style: TextStyle(
                              fontSize: context.scaleFont(12),
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF90A4AE), // Subtitle color
                              letterSpacing: 1.2,
                            ),
                          ),
                          SizedBox(height: context.scaleHeight(4)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: context.scaleHeight(16)),

                  // Menu Items (Main Content)
                  Text(
                    meal.menuItems,
                    style: TextStyle(
                      fontSize: context.scaleFont(15), // Large enough to read
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF263238), // Dark text
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),

            // Right Content: Illustration/Icon
            // Matching the design: A circular container with an icon safely placed
            SizedBox(width: context.scale(16)),
            Container(
              width: context.scale(48),
              height: context.scale(48),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA), // Very light grey bg
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  _getIllustrationIcon(meal.mealType),
                  color: _getMealColor(context, meal.mealType).withOpacity(0.8),
                  size: context.scale(24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getMealColor(BuildContext context, MealType type) {
    switch (type) {
      case MealType.breakfast:
        return const Color(0xFF5C6BC0); // Indigo
      case MealType.lunch:
        return const Color(0xFF66BB6A); // Green
      case MealType.snacks:
        return const Color(0xFFFFA726); // Orange
      case MealType.dinner:
        return const Color(0xFFEF5350); // Red
    }
  }

  IconData _getMealIcon(MealType type) {
    switch (type) {
      case MealType.breakfast:
        return Icons.coffee_outlined;
      case MealType.lunch:
        return Icons.restaurant_menu;
      case MealType.snacks:
        return Icons.bakery_dining_outlined;
      case MealType.dinner:
        return Icons.dinner_dining_outlined;
    }
  }

  IconData _getIllustrationIcon(MealType type) {
    switch (type) {
      case MealType.breakfast:
        return Icons.restaurant;
      case MealType.lunch:
        return Icons.soup_kitchen_outlined;
      case MealType.snacks:
        return Icons.coffee; // Or bread
      case MealType.dinner:
        return Icons.nightlife;
    }
  }
}
