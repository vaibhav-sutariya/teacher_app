import 'package:flutter/material.dart';
import '../../cubit/theme_cubit.dart';
import '../helpers/extensions/responsive_extensions.dart';

class AppCapsuleButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool isIconRight;
  final bool showShadow;
  final Color? color;
  final Color textColor;
  final double verticalPadding;
  final double horizontalPadding;
  final double borderRadius;
  final double fontSize;
  final double iconGap;

  const AppCapsuleButton({
    super.key,
    required this.text,
    this.icon,
    this.onTap,
    this.isIconRight = false,
    this.showShadow = true,
    this.color,
    this.textColor = Colors.white,
    this.verticalPadding = 12,
    this.horizontalPadding = 24,
    this.borderRadius = 30,
    this.fontSize = 14,
    this.iconGap = 6,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.scale(horizontalPadding),
          vertical: context.scaleHeight(verticalPadding),
        ),
        decoration: BoxDecoration(
          color: color ?? context.colors.primary,
          borderRadius: BorderRadius.circular(context.scale(borderRadius)),
          boxShadow: showShadow
              ? [
                  BoxShadow(
                    color: (color ?? context.colors.primary).withValues(
                      alpha: 0.3,
                    ),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isIconRight && icon != null) ...[
              Icon(icon, color: textColor, size: context.scale(18)),
              SizedBox(width: context.scale(iconGap)),
            ],
            Text(
              text,
              style: TextStyle(
                fontSize: context.scaleFont(fontSize),
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            if (isIconRight && icon != null) ...[
              SizedBox(width: context.scale(iconGap)),
              Icon(icon, color: textColor, size: context.scale(18)),
            ],
          ],
        ),
      ),
    );
  }
}
