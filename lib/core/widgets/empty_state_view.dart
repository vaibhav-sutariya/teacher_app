import 'package:flutter/material.dart';
import '../helpers/extensions/responsive_extensions.dart';
import '../../cubit/theme_cubit.dart';

class EmptyStateView extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData? icon;

  const EmptyStateView({
    super.key,
    this.title = 'Trust me, it is empty !',
    this.subtitle = 'No Content found. Try after some time',
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration Placeholder
          Icon(
            icon ?? Icons.sentiment_very_dissatisfied_outlined,
            size: context.scale(100),
            color: context.colors.primary.withValues(alpha: 0.1),
          ),
          SizedBox(height: context.scaleHeight(20)),
          
          Text(
            title,
            style: TextStyle(
              fontSize: context.scaleFont(18),
              fontWeight: FontWeight.bold,
              color: context.colors.primary,
            ),
          ),
          SizedBox(height: context.scaleHeight(8)),
          
          Text(
            subtitle,
            style: TextStyle(
              fontSize: context.scaleFont(14),
              color: context.colors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
