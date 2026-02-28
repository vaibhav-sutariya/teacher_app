import 'package:flutter/material.dart';
import '../../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../../cubit/theme_cubit.dart';
import '../models/ptm_model.dart';

class PtmCard extends StatelessWidget {
  final PtmModel ptm;

  const PtmCard({super.key, required this.ptm});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.scaleHeight(16)),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.colors.surface300.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Date and Time
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.scale(16),
              vertical: context.scaleHeight(12),
            ),
            decoration: BoxDecoration(
              color: context.colors.primary.withValues(alpha: 0.05),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today_rounded,
                        color: context.colors.primary,
                        size: context.scale(16),
                      ),
                      SizedBox(width: context.scale(6)),
                      Expanded(
                        child: Text(
                          ptm.date,
                          style: TextStyle(
                            fontSize: context.scaleFont(13),
                            fontWeight: FontWeight.w600,
                            color: context.colors.primary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: context.scale(8)),
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        color: context.colors.surface600,
                        size: context.scale(16),
                      ),
                      SizedBox(width: context.scale(6)),
                      Expanded(
                        child: Text(
                          ptm.time,
                          style: TextStyle(
                            fontSize: context.scaleFont(13),
                            fontWeight: FontWeight.w500,
                            color: context.colors.surface600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Body: Title, Teacher, Description, Location
          Padding(
            padding: EdgeInsets.all(context.scale(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ptm.title,
                  style: TextStyle(
                    fontSize: context.scaleFont(16),
                    fontWeight: FontWeight.bold,
                    color: context.colors.surface900,
                  ),
                ),
                SizedBox(height: context.scaleHeight(4)),
                Row(
                  children: [
                    Icon(
                      Icons.person_outline_rounded,
                      size: context.scale(16),
                      color: context.colors.surface500,
                    ),
                    SizedBox(width: context.scale(4)),
                    Text(
                      'Teacher: ${ptm.teacherName}',
                      style: TextStyle(
                        fontSize: context.scaleFont(13),
                        color: context.colors.surface600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.scaleHeight(12)),
                Text(
                  ptm.description,
                  style: TextStyle(
                    fontSize: context.scaleFont(14),
                    color: context.colors.surface600,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: context.scaleHeight(16)),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.scale(12),
                    vertical: context.scaleHeight(8),
                  ),
                  decoration: BoxDecoration(
                    color: context.colors.surface200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: context.scale(16),
                        color: context.colors.surface700,
                      ),
                      SizedBox(width: context.scale(8)),
                      Expanded(
                        child: Text(
                          ptm.location,
                          style: TextStyle(
                            fontSize: context.scaleFont(13),
                            color: context.colors.surface700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
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
