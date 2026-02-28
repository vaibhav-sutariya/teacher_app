import 'package:flutter/material.dart';

import '../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../cubit/theme_cubit.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final bool isDestructive;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.scale(16),
            vertical: context.scaleHeight(12),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isDestructive
                      ? context.colors.error.withValues(alpha: 0.1)
                      : context.colors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: isDestructive
                      ? context.colors.error
                      : context.colors.primary,
                  size: context.scale(20),
                ),
              ),
              SizedBox(width: context.scale(16)),
              Expanded(
                child: Text(
                  text,
                  style: context.textTheme.titleLarge?.copyWith(
                    color: isDestructive
                        ? context.colors.error
                        : context.colors.surface900,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: context.scale(16),
                color: context.colors.surface400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
