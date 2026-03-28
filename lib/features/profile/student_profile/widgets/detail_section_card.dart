import 'package:flutter/material.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';

class DetailSectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const DetailSectionCard({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.scale(16),
        vertical: context.scaleHeight(8),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.scale(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              context.scale(16),
              context.scaleHeight(16),
              context.scale(16),
              context.scaleHeight(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  style: TextStyle(
                    color: Colors.lightBlue.shade300,
                    fontSize: context.scaleFont(14),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
                SizedBox(height: context.scaleHeight(4)),
                Divider(color: Colors.grey.shade100, thickness: 1),
              ],
            ),
          ),
          ...children,
          SizedBox(height: context.scaleHeight(8)),
        ],
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final IconData? icon;
  final String label;
  final String value;
  final bool showDivider;

  const DetailRow({
    super.key,
    this.icon,
    required this.label,
    required this.value,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.scale(16),
            vertical: context.scaleHeight(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: context.scale(20),
                  color: Colors.pink.shade300,
                ),
                SizedBox(width: context.scale(12)),
              ],
              Expanded(
                flex: icon != null ? 1 : 2,
                child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: context.scaleFont(14),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  value,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: context.scaleFont(14),
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: icon != null ? TextAlign.start : TextAlign.start,
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.scale(16)),
            child: Divider(color: Colors.grey.shade50, height: 1),
          ),
      ],
    );
  }
}
