import 'package:flutter/material.dart';

import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../cubit/theme_cubit.dart';

/// Production-ready feedback card widget
class AttendanceFeedbackCard extends StatelessWidget {
  final String message;
  final String? title;

  const AttendanceFeedbackCard({
    super.key,
    required this.message,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.scale(16)),
      child: Card(
        color: const Color(0xFFF3E5F5), // Light purple
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.scale(16)),
        ),
        child: Padding(
          padding: EdgeInsets.all(context.scale(16)),
          child: Row(
            children: [
              Container(
                width: context.scale(48),
                height: context.scale(48),
                decoration: BoxDecoration(
                  color: context.colors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.trending_up,
                  color: Colors.white,
                  size: context.scale(24),
                ),
              ),
              SizedBox(width: context.scale(16)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null) ...[
                      Text(
                        title!,
                        style: TextStyle(
                          fontSize: context.scaleFont(16),
                          fontWeight: FontWeight.bold,
                          color: context.colors.primary,
                        ),
                      ),
                      SizedBox(height: context.scaleHeight(4)),
                    ],
                    Text(
                      message,
                      style: TextStyle(
                        fontSize: context.scaleFont(13),
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
