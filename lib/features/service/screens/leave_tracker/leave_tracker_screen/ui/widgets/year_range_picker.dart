import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

class YearRangePicker extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const YearRangePicker({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.scale(16),
        vertical: context.scaleHeight(10),
      ),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: onPrevious,
            icon: const Icon(Icons.arrow_back_ios, size: 16),
          ),
          Text(
            '${DateFormat('MMMM yyyy').format(startDate)} - ${DateFormat('MMMM yyyy').format(endDate)}',
            style: TextStyle(
              fontSize: context.scaleFont(16),
              fontWeight: FontWeight.bold,
              color: context.colors.textPrimary,
            ),
          ),
          IconButton(
            onPressed: onNext,
            icon: const Icon(Icons.arrow_forward_ios, size: 16),
          ),
        ],
      ),
    );
  }
}
