import 'package:flutter/material.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

class DashboardSectionTitle extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final VoidCallback? onTap;

  const DashboardSectionTitle({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: context.scale(24)),
          SizedBox(width: context.scale(12)),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: context.scaleFont(16),
                fontWeight: FontWeight.bold,
                color: context.colors.textPrimary,
              ),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: context.scale(16),
            color: context.colors.warning,
          ),
        ],
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const DashboardCard({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colors.textInverse,
      margin: EdgeInsets.symmetric(
        horizontal: context.scale(20),
        vertical: context.scaleHeight(8),
      ),
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.scale(16)),
      ),
      child: Padding(
        padding: padding ?? EdgeInsets.all(context.scale(16)),
        child: SizedBox(width: double.infinity, child: child),
      ),
    );
  }
}
