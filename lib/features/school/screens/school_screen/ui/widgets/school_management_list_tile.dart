import 'package:flutter/material.dart';
import '../../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../models/school_model.dart';

class SchoolManagementListTile extends StatelessWidget {
  final SchoolModuleModel module;
  final VoidCallback onTap;

  const SchoolManagementListTile({
    super.key,
    required this.module,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.scale(20),
          vertical: context.scaleHeight(10), // Reduced vertical padding
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.withValues(alpha: 0.05),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            // Icon Container
            Container(
              padding: EdgeInsets.all(context.scale(10)),
              decoration: BoxDecoration(
                color: module.backgroundColor,
                borderRadius: BorderRadius.circular(context.scale(12)),
              ),
              child: Icon(
                module.icon,
                color: module.iconColor,
                size: context.scale(20),
              ),
            ),
            SizedBox(width: context.scale(16)),
            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    module.title,
                    style: TextStyle(
                      fontSize: context.scaleFont(15),
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF263238),
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(1)),
                  Text(
                    module.subtitle,
                    style: TextStyle(
                      fontSize: context.scaleFont(12),
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ),
            // Right Suffix
            if (module.badgeText != null)
              _buildBadge(context, module.badgeText!)
            else if (module.showArrow)
              Icon(
                Icons.chevron_right,
                color: Colors.grey.shade200,
                size: context.scale(18),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(BuildContext context, String text) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.scale(8),
        vertical: context.scaleHeight(4),
      ),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(context.scale(6)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: context.scaleFont(10),
          fontWeight: FontWeight.bold,
          color: Colors.green.shade700,
        ),
      ),
    );
  }
}
