import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/core/routes/app_router.gr.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

@RoutePage()
class NoticeCircularsPage extends StatelessWidget {
  const NoticeCircularsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface100,
      appBar: AppAppBar(title: 'Notice & Circulars'),
      body: Column(
        children: [
          SizedBox(height: context.scaleHeight(20)),
          _SelectionCard(
            title: 'STUDENT NOTICE',
            icon: Icons.person_outline,
            onTap: () => context.router.push(const StudentNoticeRoute()),
          ),
          _SelectionCard(
            title: 'STAFF NOTICE',
            icon: Icons.badge_outlined,
            onTap: () => context.router.push(const StaffNoticeListRoute()),
          ),
        ],
      ),
    );
  }
}

class _SelectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _SelectionCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.scale(16),
        vertical: context.scaleHeight(8),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.scale(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(context.scale(15)),
        child: Padding(
          padding: EdgeInsets.all(context.scale(20)),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(context.scale(12)),
                decoration: BoxDecoration(
                  color: context.colors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: context.colors.primary,
                  size: context.scale(28),
                ),
              ),
              SizedBox(width: context.scale(20)),
              Text(
                title,
                style: TextStyle(
                  fontSize: context.scaleFont(16),
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                  letterSpacing: 1.0,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: context.scale(16),
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
