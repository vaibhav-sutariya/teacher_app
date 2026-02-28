import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../../cubit/theme_cubit.dart';
import '../models/achievement_model.dart';

class AchievementCard extends StatelessWidget {
  final AchievementModel achievement;

  const AchievementCard({super.key, required this.achievement});

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
          // Banner Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: CachedNetworkImage(
              imageUrl: achievement.imageUrl,
              height: context.scaleHeight(140),
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: context.colors.surface200,
                child: Center(
                  child: Icon(
                    Icons.emoji_events_rounded,
                    color: context.colors.surface400,
                    size: context.scale(40),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: context.colors.surface200,
                child: Center(
                  child: Icon(
                    Icons.error_outline_rounded,
                    color: context.colors.surface400,
                  ),
                ),
              ),
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.scale(16),
              vertical: context.scaleHeight(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category Chip & Date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.scale(10),
                        vertical: context.scaleHeight(4),
                      ),
                      decoration: BoxDecoration(
                        color: context.colors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        achievement.category,
                        style: TextStyle(
                          fontSize: context.scaleFont(13),
                          color: context.colors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      achievement.date,
                      style: TextStyle(
                        fontSize: context.scaleFont(14),
                        color: context.colors.surface600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.scaleHeight(12)),

                // Title
                Text(
                  achievement.title,
                  style: TextStyle(
                    fontSize: context.scaleFont(15),
                    fontWeight: FontWeight.bold,
                    color: context.colors.surface900,
                  ),
                ),
                SizedBox(height: context.scaleHeight(8)),

                // Description
                Text(
                  achievement.description,
                  style: TextStyle(
                    fontSize: context.scaleFont(12),
                    color: context.colors.surface500,
                    height: 1.5,
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
