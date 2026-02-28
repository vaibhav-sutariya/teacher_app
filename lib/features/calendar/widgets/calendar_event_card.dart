import 'package:flutter/material.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../models/calendar_event_model.dart';

class CalendarEventCard extends StatelessWidget {
  final CalendarEventModel event;

  const CalendarEventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.scale(16)),
      padding: EdgeInsets.all(context.scale(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.scale(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border(left: BorderSide(color: event.color, width: 4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(context.scale(10)),
            decoration: BoxDecoration(
              color: event.backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              event.icon,
              color: event.color,
              size: context.scale(24),
            ),
          ),
          SizedBox(width: context.scale(16)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: TextStyle(
                    fontSize: context.scaleFont(15),
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: context.scaleHeight(6)),
                if (event.startTime.isNotEmpty)
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: context.scale(14),
                        color: Colors.grey[500],
                      ),
                      SizedBox(width: context.scale(4)),
                      Text(
                        event.endTime.isNotEmpty
                            ? '${event.startTime} - ${event.endTime}'
                            : event.startTime,
                        style: TextStyle(
                          fontSize: context.scaleFont(12),
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                if (event.location.isNotEmpty) ...[
                  SizedBox(height: context.scaleHeight(4)),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: context.scale(14),
                        color: Colors.grey[500],
                      ),
                      SizedBox(width: context.scale(4)),
                      Expanded(
                        child: Text(
                          event.location,
                          style: TextStyle(
                            fontSize: context.scaleFont(12),
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
                SizedBox(height: context.scaleHeight(8)),
                Text(
                  event.description,
                  style: TextStyle(
                    fontSize: context.scaleFont(13),
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
