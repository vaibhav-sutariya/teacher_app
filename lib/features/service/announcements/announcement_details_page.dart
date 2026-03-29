import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../core/widgets/app_app_bar.dart';
import '../../../cubit/theme_cubit.dart';
import 'models/announcement_model.dart';

@RoutePage()
class AnnouncementDetailsPage extends StatelessWidget {
  final AnnouncementModel announcement;

  const AnnouncementDetailsPage({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppAppBar(title: 'Details'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Title/Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: context.scale(16),
                vertical: context.scaleHeight(10),
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade200, width: 1),
                ),
              ),
              child: Text(
                announcement.title.toUpperCase(),
                style: TextStyle(
                  fontSize: context.scaleFont(15),
                  fontWeight: FontWeight.bold,
                  color: context.colors.primary,
                  letterSpacing: 0.5,
                ),
              ),
            ),

            // 2. Metadata Box
            Container(
              margin: EdgeInsets.all(context.scale(16)),
              padding: EdgeInsets.all(context.scale(12)),
              width: double.infinity,
              decoration: BoxDecoration(
                color: context.colors.primary.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(context.scale(8)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('dd-MMM-yyyy hh:mm a').format(announcement.date),
                    style: TextStyle(
                      fontSize: context.scaleFont(14),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(4)),
                  Text(
                    'Notice By : ${announcement.postedBy.toUpperCase()}',
                    style: TextStyle(
                      fontSize: context.scaleFont(12),
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // 3. Content
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.scale(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Announcement Content',
                    style: TextStyle(
                      fontSize: context.scaleFont(14),
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(20)),
                  Text(
                    announcement.content,
                    style: TextStyle(
                      fontSize: context.scaleFont(14),
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
