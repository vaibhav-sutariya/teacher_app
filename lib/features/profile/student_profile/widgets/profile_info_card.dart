import 'package:flutter/material.dart';

import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../cubit/theme_cubit.dart';

class ProfileInfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const ProfileInfoCard({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.scaleHeight(16)),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: context.colors.surface300.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.all(context.scale(16)),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: context.colors.primary,
                  size: context.scale(20),
                ),
                SizedBox(width: context.scale(8)),
                Text(
                  title.toUpperCase(),
                  style: context.textTheme.titleMedium?.copyWith(
                    color: context.colors.surface500,
                    fontWeight: FontWeight.w600,
                    fontSize: context.scaleFont(13),
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: context.colors.surface300.withValues(alpha: 0.2),
          ),
          // Content
          Padding(
            padding: padding ?? EdgeInsets.all(context.scale(16)),
            child: child,
          ),
        ],
      ),
    );
  }
}
