import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../core/helpers/extensions/responsive_extensions.dart';


/// Production-ready teacher information section widget
/// Optimized for performance with const constructor
class TeacherInfoSection extends StatelessWidget {
  final String? teacherName;
  final String? teacherRole;
  final String? teacherAvatarUrl;

  const TeacherInfoSection({
    super.key,
    this.teacherName,
    this.teacherRole,
    this.teacherAvatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'UPDATED BY',
          style: TextStyle(
            fontSize: context.scaleFont(11),
            fontWeight: FontWeight.w600,
            color: Colors.grey[600],
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: context.scaleHeight(12)),
        Row(
          children: [
            // Teacher Avatar
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(context.scale(30)),
                  child: CachedNetworkImage(
                    imageUrl: teacherAvatarUrl ??
                        'https://i.pravatar.cc/150?u=teacher_jigna',
                    width: context.scale(60),
                    height: context.scale(60),
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: context.scale(60),
                      height: context.scale(60),
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.person,
                        color: Colors.grey[600],
                        size: context.scale(30),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: context.scale(60),
                      height: context.scale(60),
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.person,
                        color: Colors.grey[600],
                        size: context.scale(30),
                      ),
                    ),
                  ),
                ),
                // Online status badge
                Positioned(
                  right: -2,
                  bottom: -2,
                  child: Container(
                    width: context.scale(16),
                    height: context.scale(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: context.scale(12)),
            // Teacher Name and Role
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    teacherName ?? 'Jigna Panchal',
                    style: TextStyle(
                      fontSize: context.scaleFont(18),
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(4)),
                  Text(
                    teacherRole ?? 'Class Teacher • Grade 4-B',
                    style: TextStyle(
                      fontSize: context.scaleFont(14),
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
