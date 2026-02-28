import 'package:flutter/material.dart';

import '../../../../../core/helpers/extensions/responsive_extensions.dart';


/// Production-ready remark detail item widget
/// Optimized for performance with const constructor
class RemarkDetailItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final Color? valueColor;
  final bool showDot;

  const RemarkDetailItem({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    this.valueColor,
    this.showDot = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon
        Container(
          padding: EdgeInsets.all(context.scale(8)),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(context.scale(8)),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: context.scale(24),
          ),
        ),
        SizedBox(width: context.scale(12)),
        // Label and Value
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: context.scaleFont(12),
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: context.scaleHeight(4)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: context.scaleFont(14),
                        fontWeight: FontWeight.w600,
                        color: valueColor ?? const Color(0xFF1A1A1A),
                        height: 1.3,
                      ),
                    ),
                  ),
                  if (showDot)
                    Container(
                      margin: EdgeInsets.only(
                        left: context.scale(4),
                        top: context.scaleHeight(6),
                      ),
                      width: context.scale(6),
                      height: context.scale(6),
                      decoration: BoxDecoration(
                        color: valueColor ?? const Color(0xFFE53935),
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
