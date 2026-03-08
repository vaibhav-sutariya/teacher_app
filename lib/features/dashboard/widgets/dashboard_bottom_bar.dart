import 'package:flutter/material.dart';

import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../cubit/theme_cubit.dart';

class DashboardBottomBar extends StatelessWidget {
  final int activeIndex;
  final Function(int) onTabSelected;

  const DashboardBottomBar({
    super.key,
    required this.activeIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.scaleHeight(60),
      decoration: BoxDecoration(
        color: context.colors.textInverse,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(context, 0, Icons.home, Icons.home_outlined, 'Home'),
          _buildNavItem(
            context,
            1,
            Icons.groups,
            Icons.groups_outlined,
            'My Class',
          ),
          _buildNavItem(
            context,
            2,
            Icons.school,
            Icons.school_outlined,
            'School',
          ),
          _buildNavItem(
            context,
            3,
            Icons.grid_view_rounded,
            Icons.grid_view_outlined,
            'Services',
          ),
          _buildNavItem(context, 4, Icons.person, Icons.person_outline, 'Me'),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    int index,
    IconData selectedIcon,
    IconData unselectedIcon,
    String label,
  ) {
    final bool isSelected = activeIndex == index;
    final primaryColor = context.colors.primary;
    final unselectedColor = const Color(
      0xFF8B9CB6,
    ); // Matching the slate gray-blue in the image

    return Expanded(
      child: GestureDetector(
        onTap: () => onTabSelected(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? selectedIcon : unselectedIcon,
              color: isSelected ? primaryColor : unselectedColor,
              size: context.scale(24),
            ),
            SizedBox(height: context.scaleHeight(4)),
            Text(
              label,
              style: TextStyle(
                fontSize: context.scaleFont(12),
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                color: isSelected ? primaryColor : unselectedColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
