import 'package:flutter/material.dart';

import '../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../cubit/theme_cubit.dart';
import '../models/summary_model.dart';

class SummaryHeader extends StatelessWidget {
  final SummaryHeaderModel model;

  const SummaryHeader({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: WavyHeaderClipper(),
          child: Container(
            height: context.scaleHeight(220),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  context.colors.primary.withValues(alpha: 0.1),
                  context.colors.primary.withValues(alpha: 0.3),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        Positioned(
          top: context.scaleHeight(50),
          left: context.scale(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.date,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colors.surface600,
                ),
              ),
              SizedBox(height: context.scaleHeight(4)),
              Text(
                model.greeting,
                style: context.textTheme.displaySmall?.copyWith(
                  color: context.colors.error.withValues(alpha: 0.7),
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                model.userName.toUpperCase(),
                style: context.textTheme.headlineSmall?.copyWith(
                  color: context.colors.error.withValues(alpha: 0.8),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        // Decorative Stars and Shapes to match the design image
        Positioned(
          top: context.scaleHeight(10),
          left: context.scale(100),
          child: Opacity(
            opacity: 0.3,
            child: const Icon(Icons.star, color: Colors.amber, size: 24),
          ),
        ),
        Positioned(
          top: context.scaleHeight(40),
          right: context.scale(60),
          child: Opacity(
            opacity: 0.2,
            child: const Icon(Icons.star_border, color: Colors.blue, size: 18),
          ),
        ),
        Positioned(
          bottom: context.scaleHeight(80),
          right: context.scale(100),
          child: Opacity(
            opacity: 0.2,
            child: Transform.rotate(
              angle: 0.5,
              child: const Icon(Icons.category, color: Colors.orange, size: 30),
            ),
          ),
        ),
        Positioned(
          right: context.scale(20),
          top: context.scaleHeight(60),
          child: Icon(
            Icons.rocket_launch,
            size: context.scale(60),
            color: context.colors.primary.withValues(alpha: 0.3),
          ),
        ),
      ],
    );
  }
}

class WavyHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 60);

    var firstControlPoint = Offset(size.width * 0.25, size.height);
    var firstEndPoint = Offset(size.width * 0.5, size.height - 40);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    var secondControlPoint = Offset(size.width * 0.75, size.height - 80);
    var secondEndPoint = Offset(size.width, size.height - 20);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class AttendancePill extends StatelessWidget {
  final String status;

  const AttendancePill({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: context.scale(20)),
      padding: EdgeInsets.symmetric(vertical: context.scaleHeight(10)),
      decoration: BoxDecoration(
        color: context.colors.success.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: context.colors.success.withValues(alpha: 0.1),
        ),
      ),
      child: Center(
        child: Text(
          status,
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.colors.success.withValues(alpha: 0.7),
          ),
        ),
      ),
    );
  }
}

class AcademicCard extends StatelessWidget {
  final AcademicPickModel model;

  const AcademicCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    IconData getIcon() {
      switch (model.type) {
        case AcademicPickType.classwork:
          return Icons.assignment_outlined;
        case AcademicPickType.homework:
          return Icons.home_work_outlined;
        case AcademicPickType.exam:
          return Icons.assignment_turned_in_outlined;
        case AcademicPickType.event:
          return Icons.event_note_outlined;
      }
    }

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.scale(20),
        vertical: context.scaleHeight(8),
      ),
      padding: EdgeInsets.all(context.scale(16)),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.surface200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.colors.error.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              getIcon(),
              color: context.colors.error.withValues(alpha: 0.6),
            ),
          ),
          SizedBox(width: context.scale(16)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title,
                  style: context.textTheme.titleLarge?.copyWith(
                    color: context.colors.error.withValues(alpha: 0.6),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  model.subtitle,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.colors.surface900,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  context.colors.primary.withValues(alpha: 0.7),
                  context.colors.primary.withValues(alpha: 0.9),
                ],
              ),
            ),
            child: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}
