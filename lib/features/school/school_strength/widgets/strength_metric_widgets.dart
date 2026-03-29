import 'package:flutter/material.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final Color backgroundColor;

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    this.backgroundColor = const Color(0xFFA1887F),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: context.scaleHeight(20),
        horizontal: context.scale(16),
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(context.scale(12)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: context.scaleFont(28),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: context.scaleHeight(4)),
          Text(
            title,
            style: TextStyle(
              fontSize: context.scaleFont(14),
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }
}

class GenderSplitCard extends StatelessWidget {
  final int girlsCount;
  final int boysCount;
  final Color backgroundColor;

  const GenderSplitCard({
    super.key,
    required this.girlsCount,
    required this.boysCount,
    this.backgroundColor = const Color(0xFFFF8A65),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(context.scale(12)),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Girls Section
            Expanded(
              child: _GenderSection(
                label: 'GIRLS',
                count: girlsCount,
              ),
            ),
            // Divider
            VerticalDivider(
              color: Colors.white.withValues(alpha: 0.3),
              width: 1,
              indent: context.scaleHeight(15),
              endIndent: context.scaleHeight(15),
            ),
            // Boys Section
            Expanded(
              child: _GenderSection(
                label: 'BOYS',
                count: boysCount,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GenderSection extends StatelessWidget {
  final String label;
  final int count;

  const _GenderSection({required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.scaleHeight(20)),
      child: Column(
        children: [
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: context.scaleFont(28),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: context.scaleHeight(4)),
          Text(
            label,
            style: TextStyle(
              fontSize: context.scaleFont(14),
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailMetricBox extends StatelessWidget {
  final String label;
  final String value;
  final Color textColor;

  const DetailMetricBox({
    super.key,
    required this.label,
    required this.value,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: context.scaleHeight(12),
        horizontal: context.scale(8),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: context.colors.divider.withValues(alpha: 0.1)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: context.scaleFont(20),
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          SizedBox(height: context.scaleHeight(4)),
          Text(
            label,
            style: TextStyle(
              fontSize: context.scaleFont(11),
              fontWeight: FontWeight.bold,
              color: context.colors.textSecondary.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}
