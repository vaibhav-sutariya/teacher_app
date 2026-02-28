import 'package:flutter/material.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../cubit/theme_cubit.dart';
import '../models/notification_model.dart';
import 'package:intl/intl.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;

  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.scaleHeight(16)),
      padding: EdgeInsets.all(context.scale(16)),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.colors.surface300.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: context.colors.surface200.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIconArea(context),
              SizedBox(width: context.scale(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          notification.title,
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.colors.primary,
                          ),
                        ),
                        Text(
                          DateFormat('hh:mm a').format(notification.time),
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colors.surface400,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    if (notification.tag != null) ...[
                      SizedBox(height: context.scaleHeight(4)),
                      _buildTag(context, notification.tag!),
                    ],
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: context.scaleHeight(12)),
          _buildRichDescription(context, notification.description),
        ],
      ),
    );
  }

  Widget _buildIconArea(BuildContext context) {
    Color bgColor;
    Color iconColor;

    switch (notification.type) {
      case NotificationType.attendance:
        bgColor = const Color(0xFFE8F5E9); // Light Green
        iconColor = const Color(0xFF2E7D32); // Dark Green
        break;
      case NotificationType.leave:
        bgColor = const Color(0xFFE3F2FD); // Light Blue
        iconColor = context.colors.primary;
        break;
      case NotificationType.feeAlert:
        bgColor = const Color(0xFFFFEBEE); // Light Red
        iconColor = const Color(0xFFD32F2F); // Dark Red
        break;
      case NotificationType.schoolEvent:
        bgColor = const Color(0xFFFFF8E1); // Light Amber
        iconColor = const Color(0xFFF57F17); // Dark Amber
        break;
      case NotificationType.general:
        bgColor = context.colors.surface200;
        iconColor = context.colors.surface700;
        break;
    }

    return Container(
      width: context.scale(42),
      height: context.scale(42),
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      child: Icon(notification.icon, color: iconColor, size: context.scale(20)),
    );
  }

  Widget _buildTag(BuildContext context, String tag) {
    Color bgColor;
    Color textColor;

    switch (notification.type) {
      case NotificationType.attendance:
        bgColor = const Color(0xFFE8F5E9);
        textColor = const Color(0xFF2E7D32);
        break;
      case NotificationType.leave:
        bgColor = const Color(0xFFE3F2FD);
        textColor = context.colors.primary;
        break;
      case NotificationType.feeAlert:
        bgColor = const Color(0xFFFFEBEE);
        textColor = const Color(0xFFD32F2F);
        break;
      default:
        bgColor = context.colors.surface200;
        textColor = context.colors.surface700;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.scale(8),
        vertical: context.scaleHeight(2),
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        tag.toUpperCase(),
        style: TextStyle(
          color: textColor,
          fontSize: context.scaleFont(9),
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildRichDescription(BuildContext context, String text) {
    // Simple parser to make **text** bold
    final List<TextSpan> spans = [];
    final parts = text.split('**');

    for (int i = 0; i < parts.length; i++) {
      if (i % 2 == 1) {
        // Bold part
        spans.add(
          TextSpan(
            text: parts[i],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color:
                  notification.type == NotificationType.attendance &&
                      parts[i].toLowerCase() == 'present'
                  ? const Color(0xFF2E7D32)
                  : context.colors.surface900,
            ),
          ),
        );
      } else {
        // Normal part
        spans.add(
          TextSpan(
            text: parts[i],
            style: TextStyle(color: context.colors.surface700),
          ),
        );
      }
    }

    return RichText(
      text: TextSpan(
        style: context.textTheme.bodyMedium?.copyWith(
          height: 1.4,
          fontSize: context.scaleFont(13),
        ),
        children: spans,
      ),
    );
  }
}
