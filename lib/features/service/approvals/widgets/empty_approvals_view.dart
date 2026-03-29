import 'package:flutter/material.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

class EmptyApprovalsView extends StatelessWidget {
  const EmptyApprovalsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration Placeholder (matches the ghost-like figure in screenshot)
          Icon(
            Icons.sentiment_very_dissatisfied_outlined,
            size: context.scale(100),
            color: context.colors.primary.withValues(alpha: 0.1),
          ),
          SizedBox(height: context.scaleHeight(20)),
          
          Text(
            'Trust me, it is empty !',
            style: TextStyle(
              fontSize: context.scaleFont(18),
              fontWeight: FontWeight.bold,
              color: context.colors.primary,
            ),
          ),
          SizedBox(height: context.scaleHeight(8)),
          
          Text(
            'No Content found. Try after some time',
            style: TextStyle(
              fontSize: context.scaleFont(12),
              color: context.colors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
