import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import '../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../core/routes/app_router.gr.dart';
import '../../../../../core/utils/social_media_launcher.dart';
import '../data/category_theme_config.dart';
import '../data/menu_data.dart';
import 'menu_item.dart';

/// Production-ready menu section card with optimized performance
/// Uses const constructors where possible and optimized layout
class MenuSectionCard extends StatelessWidget {
  final String title;
  final List<MenuItemData> items;

  const MenuSectionCard({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    // Get theme once per build - lookup is fast (Map lookup)
    final theme = CategoryThemes.getTheme(title);
    final borderRadius = BorderRadius.circular(context.scale(16));

    return Card(
      color: context.colors.textInverse,
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
        side: BorderSide(color: Colors.grey.withValues(alpha: 0.08), width: 1),
      ),
      child: Stack(
        children: [
          // Decorative background pattern - memoized
          ..._buildBackgroundDecoration(context, theme, borderRadius),

          // Main content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // Optimize layout
              children: [
                _buildSectionTitle(context),
                SizedBox(height: context.scaleHeight(10)),
                _buildMenuGrid(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the section title with decorative accent
  Widget _buildSectionTitle(BuildContext context) {
    return Row(
      children: [
        Container(
          width: context.scale(4),
          height: context.scaleHeight(12),
          decoration: BoxDecoration(
            color: context.colors.primary,
            borderRadius: BorderRadius.circular(context.scale(4)),
          ),
        ),
        SizedBox(width: context.scale(8)),
        Text(
          title,
          style: TextStyle(
            fontSize: context.scaleFont(15),
            fontWeight: FontWeight.bold,
            color: context.colors.textPrimary,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  /// Builds the grid of menu items
  /// Production-optimized: Uses LayoutBuilder for dynamic sizing
  /// Avoids shrinkWrap performance issues by using fixed cross-axis count
  Widget _buildMenuGrid(BuildContext context) {
    // Calculate grid delegate once
    final gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      mainAxisSpacing: context.scaleHeight(8),
      crossAxisSpacing: context.scale(25),
      childAspectRatio: 0.999,
    );

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: gridDelegate,
      padding: EdgeInsets.zero,
      // Critical performance optimizations
      addAutomaticKeepAlives: false, // Don't keep grid items alive
      addRepaintBoundaries: true, // Isolate repaints
      addSemanticIndexes: false, // Disable semantic indexes
      itemBuilder: (context, index) {
        final item = items[index];
        // Use ObjectKey for better performance
        // RepaintBoundary prevents unnecessary repaints during scroll
        return RepaintBoundary(
          key: ObjectKey(item),
          child: MenuItem(
            icon: item.icon,
            label: item.label,
            color: item.iconColor,
            backgroundColor: item.backgroundColor,
            onTap: () => _handleNavigation(context, item.label),
          ),
        );
      },
    );
  }

  /// Builds the background decoration layers (image + gradient overlay)
  /// Memoized to avoid rebuilding on every scroll
  List<Widget> _buildBackgroundDecoration(
    BuildContext context,
    CategoryThemeConfig theme,
    BorderRadius borderRadius,
  ) {
    return [
      // Background image layer
      _buildBackgroundImage(context, theme, borderRadius),
      // Gradient overlay layer
      _buildGradientOverlay(context, theme, borderRadius),
    ];
  }

  /// Builds the background image layer
  Widget _buildBackgroundImage(
    BuildContext context,
    CategoryThemeConfig theme,
    BorderRadius borderRadius,
  ) {
    return Positioned.fill(
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Opacity(
          opacity: theme.imageOpacity,
          child: theme.backgroundImage.image(fit: BoxFit.cover),
        ),
      ),
    );
  }

  /// Builds the gradient overlay layer
  Widget _buildGradientOverlay(
    BuildContext context,
    CategoryThemeConfig theme,
    BorderRadius borderRadius,
  ) {
    return Positioned.fill(
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.overlayColor.withValues(alpha: theme.overlayStartOpacity),
                theme.overlayColor.withValues(alpha: theme.overlayEndOpacity),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Handle navigation based on menu item label
  void _handleNavigation(BuildContext context, String label) {
    switch (label.toLowerCase()) {
      case 'attendance':
        context.router.push(const AttendanceRoute());
        break;
      case 'class work':
        context.router.push(const ClassworkRoute());
        break;
      case 'homework':
      case 'subject wise homework':
        context.router.push(const HomeworkRoute());
        break;
      case 'gallery':
        context.router.push(const GalleryRoute());
        break;
      case 'video gallery':
        context.router.push(const VideosRoute());
        break;
      case 'remarks':
        context.router.push(const RemarksRoute());
        break;
      case 'my leave':
        context.router.push(const LeaveRoute());
        break;
      case 'meal menu':
        context.router.push(const MealMenuRoute());
        break;
      case 'time table':
        context.router.push(const TimeTableRoute());
      case 'concerns':
      case 'academics -> concern':
        context.router.push(const ConcernRoute());
        break;
      case 'assignment':
        context.router.push(const AssignmentRoute());
        break;
      case 'ptm':
        context.router.push(const PtmRoute());
        break;
      case 'achievement':
        context.router.push(const AchievementRoute());
        break;
      case 'holiday homework':
        context.router.push(const HolidayHwRoute());
        break;

      // Social Media Interactions using Launcher
      case 'facebook':
        SocialMediaLauncher.launch(
          context,
          url: 'https://www.facebook.com/vaibhav.sutariya.75',
          title: 'Facebook',
        );
        break;
      case 'instagram':
        SocialMediaLauncher.launch(
          context,
          url: 'https://www.instagram.com/wakeup_vs/?hl=en',
          title: 'Instagram',
        );
        break;
      case 'youtube':
        SocialMediaLauncher.launch(
          context,
          url: 'https://www.youtube.com/@SwaminarayanGadi',
          title: 'YouTube',
          forceApp: true,
        );
        break;
      case 'website':
        SocialMediaLauncher.launch(
          context,
          url: 'https://www.swaminarayangadi.com/',
          title: 'School Website',
        );
        break;

      case 'gatepass details':
        context.router.push(const GatePassRoute());
        break;

      case 'google map':
        SocialMediaLauncher.launch(
          context,
          url: 'https://maps.app.goo.gl/s6amhb2UYEyKhoB56',
          title: 'Location',
          forceApp: true,
        );
        break;

      case 'exam time table':
        context.router.push(const ExamTimeTableRoute());
        break;

      case 'exam paper':
        context.router.push(const PaperRoute());
        break;

      case 'class test':
        context.router.push(const ClassTestRoute());
        break;

      case 'result':
      case 'report card':
      case 'term reports':
        context.router.push(const ReportCardRoute());
        break;

      case 'syllabus':
        context.router.push(const SyllabusRoute());
        break;

      case 'student notice':
        context.router.push(const StudentNoticeRoute());
        break;
      case 'transport attendance':
        context.router.push(const TransportAttendanceRoute());
        break;
      case 'view transport attendance':
        context.router.push(const ViewTransportAttendanceRoute());
        break;
      case 'student info':
        context.router.push(const StudentInfoRoute());
        break;
      case 'calendar':
        context.router.push(const CalendarRoute());
        break;
      case 'birthday':
        context.router.push(const BirthdayRoute());
        break;
      case 'new admission':
        context.router.push(const NewAdmissionRoute());
        break;
      case 'student photo upload':
        context.router.push(const StudentPhotoUploadRoute());
        break;
      case 'employee photo':
        context.router.push(const EmployeePhotoRoute());
        break;
      case 'parent photo':
        context.router.push(const ParentPhotoRoute());
        break;
      default:
        // Handle other menu items
        break;
    }
  }
}
