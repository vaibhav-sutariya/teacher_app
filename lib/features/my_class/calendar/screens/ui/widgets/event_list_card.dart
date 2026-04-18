import 'package:flutter/material.dart';
import '../../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../../cubit/theme_cubit.dart';
import '../../../models/calendar_event_model.dart';

class EventListCard extends StatelessWidget {
  final CalendarEventModel event;

  const EventListCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.scale(16),
        vertical: context.scaleHeight(6),
      ),
      padding: EdgeInsets.all(context.scale(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.scale(12)),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: context.scaleHeight(4)),
            width: context.scale(8),
            height: context.scale(8),
            decoration: BoxDecoration(
              color: event.typeColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: context.scale(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: TextStyle(
                    fontSize: context.scaleFont(15),
                    fontWeight: FontWeight.w600,
                    color: context.colors.textPrimary,
                  ),
                ),
                SizedBox(height: context.scaleHeight(4)),
                Row(
                  children: [
                    Icon(
                      Icons.people_outline,
                      size: context.scale(14),
                      color: Colors.grey.shade500,
                    ),
                    SizedBox(width: context.scale(4)),
                    Text(
                      'For class: ${event.targetClass}',
                      style: TextStyle(
                        fontSize: context.scaleFont(12),
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
