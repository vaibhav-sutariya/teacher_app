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
    return SizedBox(
      height: context.scaleHeight(70),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          // Background Bar
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: context.scaleHeight(50),
              margin: EdgeInsets.fromLTRB(
                context.scale(15),
                0,
                context.scale(15),
                context.scaleHeight(5),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(context.scale(15)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: context.scale(25),
                    spreadRadius: context.scale(2),
                    offset: Offset(0, context.scaleHeight(8)),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: _buildNavItem(
                        context,
                        1,
                        Icons.calendar_month_rounded,
                        'Calendar',
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: _buildNavItem(
                        context,
                        2,
                        Icons.explore_rounded,
                        'Summary',
                      ),
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ), // Space for floating button
                  Expanded(
                    child: Center(
                      child: _buildNavItem(
                        context,
                        3,
                        Icons.notifications_rounded,
                        'Notice',
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: _buildNavItem(
                        context,
                        4,
                        Icons.person_rounded,
                        'Me',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -15,
            child: GestureDetector(
              onTap: () {
                onTabSelected(0); // Select Home tab (index 0)
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: context.scale(50),
                    height: context.scale(50),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF150E9F), Color(0xFF342AF2)],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: context.colors.primary.withOpacity(0.5),
                          blurRadius: context.scale(8),
                          // spreadRadius: context.scale(1),
                          offset: Offset(0, context.scaleHeight(2)),
                        ),
                      ],
                      // Highlight if selected
                      border: activeIndex == 0
                          ? Border.all(
                              color: Colors.white,
                              width: context.scale(2),
                            )
                          : null,
                    ),
                    child: Icon(
                      Icons.home_rounded,
                      color: activeIndex == 0 ? Colors.white : Colors.white,
                      size: context.scale(26),
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(5)),
                  Text(
                    'Home',
                    style: TextStyle(
                      fontSize: context.scaleFont(12),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: activeIndex == 0
                          ? context.colors.primary
                          : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    int index,
    IconData icon,
    String label,
  ) {
    final bool isSelected = activeIndex == index;
    final primaryColor = context.colors.primary;

    return GestureDetector(
      onTap: () => onTabSelected(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? primaryColor : Colors.grey[600],
            size: context.scale(22),
          ),
          SizedBox(height: context.scaleHeight(4)),
          Text(
            label,
            style: TextStyle(
              fontSize: context.scaleFont(12),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? primaryColor : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
