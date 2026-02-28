import 'package:flutter/material.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';

class AcademicYearSelector extends StatelessWidget {
  final String selectedYear;
  final List<String> years;
  final ValueChanged<String?> onChanged;

  const AcademicYearSelector({
    super.key,
    required this.selectedYear,
    required this.years,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.scale(16),
        vertical: context.scale(
          4,
        ), // Reduced vertical padding for DropdownButton
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.scale(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedYear,
          icon: Container(
            padding: EdgeInsets.all(context.scale(8)),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F2F5),
              borderRadius: BorderRadius.circular(context.scale(8)),
            ),
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: const Color(0xFF1A237E),
              size: context.scale(24),
            ),
          ),
          isExpanded: true,
          style: TextStyle(
            fontSize: context.scaleFont(18),
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1A237E), // Deep Blue
            fontFamily: 'Inter', // Assuming Inter is used, or default
          ),
          items: years.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'SELECTED ACADEMIC YEAR',
                    style: TextStyle(
                      fontSize: context.scaleFont(10),
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                      letterSpacing: 1.0,
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(4)),
                  Text(value),
                ],
              ),
            );
          }).toList(),
          onChanged: onChanged,
          selectedItemBuilder: (context) {
            return years.map<Widget>((String value) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'SELECTED ACADEMIC YEAR',
                    style: TextStyle(
                      fontSize: context.scaleFont(10),
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                      letterSpacing: 1.0,
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(4)),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: context.scaleFont(18),
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A237E), // Deep Blue
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              );
            }).toList();
          },
        ),
      ),
    );
  }
}
