import 'package:flutter/material.dart';

import '../../cubit/theme_cubit.dart';
import '../helpers/extensions/responsive_extensions.dart';

/// Production-ready reusable tab bar component
/// Features:
/// - Minimal rebuilds (only when selected index changes)
/// - Theme-aligned design
/// - Smooth animations
/// - Globally reusable
/// - High performance
class AppTabBar extends StatelessWidget {
  /// List of tab labels
  final List<String> tabs;

  /// Currently selected tab index
  final int selectedIndex;

  /// Callback when tab is tapped
  final ValueChanged<int> onTabChanged;

  /// Color for selected tab (defaults to primary color)
  final Color? selectedColor;

  /// Color for unselected tabs (defaults to grey)
  final Color? unselectedColor;

  /// Color for the indicator line (defaults to primary color)
  final Color? indicatorColor;

  /// Background color of the tab bar
  final Color? backgroundColor;

  const AppTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabChanged,
    this.selectedColor,
    this.unselectedColor,
    this.indicatorColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final greyColor = unselectedColor ?? Colors.white.withOpacity(0.7);
    final indicatorClr = indicatorColor ?? Colors.white;
    final bgColor = backgroundColor ?? context.colors.primary;

    return Container(
      color: bgColor,
      padding: EdgeInsets.symmetric(
        horizontal: context.scale(16),
        // vertical: context.scaleHeight(2),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = index == selectedIndex;
          return Expanded(
            child: _TabItem(
              label: tabs[index],
              isSelected: isSelected,
              selectedColor: Colors.white,
              unselectedColor: greyColor,
              indicatorColor: indicatorClr,
              onTap: () => onTabChanged(index),
            ),
          );
        }),
      ),
    );
  }
}

/// Individual tab item widget
/// Separated for better performance with RepaintBoundary
class _TabItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color selectedColor;
  final Color unselectedColor;
  final Color indicatorColor;
  final VoidCallback onTap;

  const _TabItem({
    required this.label,
    required this.isSelected,
    required this.selectedColor,
    required this.unselectedColor,
    required this.indicatorColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: context.scaleHeight(6)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Tab label
              Text(
                label,
                style: TextStyle(
                  fontSize: context.scaleFont(14),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? selectedColor : unselectedColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: context.scaleHeight(4)),
              // Indicator line
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                height: context.scaleHeight(3),
                width: isSelected ? context.scale(40) : 0,
                decoration: BoxDecoration(
                  color: indicatorColor,
                  borderRadius: BorderRadius.circular(context.scale(2)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
