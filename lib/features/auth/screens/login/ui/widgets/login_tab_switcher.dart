import 'package:flutter/material.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

class LoginTabSwitcher extends StatelessWidget {
  final ValueNotifier<int> selectedIndexNotifier;

  const LoginTabSwitcher({super.key, required this.selectedIndexNotifier});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: context.colors.surface100, // Light grey background
        borderRadius: BorderRadius.circular(16),
      ),
      child: ValueListenableBuilder<int>(
        valueListenable: selectedIndexNotifier,
        builder: (context, selectedIndex, _) {
          return Row(
            children: [
              _buildTab(
                context,
                title: 'Phone Number',
                isSelected: selectedIndex == 0,
                onTap: () => selectedIndexNotifier.value = 0,
              ),
              _buildTab(
                context,
                title: 'Email Address',
                isSelected: selectedIndex == 1,
                onTap: () => selectedIndexNotifier.value = 1,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTab(
    BuildContext context, {
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? context.colors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : context.colors.textSecondary,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
