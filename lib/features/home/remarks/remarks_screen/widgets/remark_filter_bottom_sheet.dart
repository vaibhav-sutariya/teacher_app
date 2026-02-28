import 'package:flutter/material.dart';

import '../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../core/widgets/app_primary_button.dart';
import '../../../../../cubit/theme_cubit.dart';
import '../models/remark_model.dart';

/// Production-ready filter bottom sheet widget with checkbox support
/// Optimized for performance with proper state management
class RemarkFilterBottomSheet extends StatefulWidget {
  final List<RemarkCategory> selectedCategories;
  final List<RemarkType> selectedTypes;
  final Function(List<RemarkCategory>, List<RemarkType>) onApplyFilters;
  final VoidCallback onClearFilters;

  const RemarkFilterBottomSheet({
    super.key,
    required this.selectedCategories,
    required this.selectedTypes,
    required this.onApplyFilters,
    required this.onClearFilters,
  });

  @override
  State<RemarkFilterBottomSheet> createState() =>
      _RemarkFilterBottomSheetState();
}

class _RemarkFilterBottomSheetState extends State<RemarkFilterBottomSheet> {
  late List<RemarkCategory> _selectedCategories;
  late List<RemarkType> _selectedTypes;

  @override
  void initState() {
    super.initState();
    _selectedCategories = List.from(widget.selectedCategories);
    _selectedTypes = List.from(widget.selectedTypes);
  }

  void _toggleCategory(RemarkCategory category) {
    setState(() {
      if (_selectedCategories.contains(category)) {
        _selectedCategories.remove(category);
      } else {
        _selectedCategories.add(category);
      }
    });
  }

  void _toggleType(RemarkType type) {
    setState(() {
      if (_selectedTypes.contains(type)) {
        _selectedTypes.remove(type);
      } else {
        _selectedTypes.add(type);
      }
    });
  }

  void _applyFilters() {
    widget.onApplyFilters(_selectedCategories, _selectedTypes);
    Navigator.of(context).pop();
  }

  void _clearFilters() {
    widget.onClearFilters();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final hasActiveFilters =
        _selectedCategories.isNotEmpty || _selectedTypes.isNotEmpty;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(context.scale(20)),
          topRight: Radius.circular(context.scale(20)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: context.scaleHeight(12)),
            width: context.scale(40),
            height: context.scaleHeight(4),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(context.scale(2)),
            ),
          ),
          SizedBox(height: context.scaleHeight(20)),
          // Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.scale(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter Remarks',
                  style: TextStyle(
                    fontSize: context.scaleFont(20),
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
                // Always reserve space for Clear button to prevent size changes
                AnimatedOpacity(
                  opacity: hasActiveFilters ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: IgnorePointer(
                    ignoring: !hasActiveFilters,
                    child: TextButton(
                      onPressed: _clearFilters,
                      child: Text(
                        'Clear',
                        style: TextStyle(
                          fontSize: context.scaleFont(14),
                          fontWeight: FontWeight.w600,
                          color: context.colors.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: context.scaleHeight(10)),
          // Categories section
          _FilterSection(
            title: 'Categories',
            items: [
              _FilterItem(
                label: 'Daily Routine',
                value: RemarkCategory.dailyRoutine,
                isSelected: _selectedCategories.contains(
                  RemarkCategory.dailyRoutine,
                ),
                onTap: () => _toggleCategory(RemarkCategory.dailyRoutine),
              ),
              _FilterItem(
                label: 'Behaviour',
                value: RemarkCategory.behaviour,
                isSelected: _selectedCategories.contains(
                  RemarkCategory.behaviour,
                ),
                onTap: () => _toggleCategory(RemarkCategory.behaviour),
              ),
              _FilterItem(
                label: 'Class Work',
                value: RemarkCategory.classWork,
                isSelected: _selectedCategories.contains(
                  RemarkCategory.classWork,
                ),
                onTap: () => _toggleCategory(RemarkCategory.classWork),
              ),
            ],
          ),
          SizedBox(height: context.scaleHeight(16)),
          // Types section
          _FilterSection(
            title: 'Type',
            items: [
              _FilterItem(
                label: 'Positive',
                value: RemarkType.positive,
                isSelected: _selectedTypes.contains(RemarkType.positive),
                onTap: () => _toggleType(RemarkType.positive),
              ),
              _FilterItem(
                label: 'Negative',
                value: RemarkType.negative,
                isSelected: _selectedTypes.contains(RemarkType.negative),
                onTap: () => _toggleType(RemarkType.negative),
              ),
            ],
          ),
          SizedBox(height: context.scaleHeight(32)),
          // Apply button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.scale(20)),
            child: AppPrimaryButton(
              onPressed: _applyFilters,
              text: 'Apply Filters',
              height: context.scaleHeight(50),
              borderRadius: context.scale(12),
            ),
          ),
          SizedBox(height: context.scaleHeight(20)),
        ],
      ),
    );
  }
}

/// Filter section widget
class _FilterSection extends StatelessWidget {
  final String title;
  final List<_FilterItem> items;

  const _FilterSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.scale(20)),
          child: Text(
            title,
            style: TextStyle(
              fontSize: context.scaleFont(16),
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1A1A1A),
            ),
          ),
        ),
        // SizedBox(height: context.scaleHeight(12)),
        ...items.map((item) => item),
      ],
    );
  }
}

/// Filter item widget with checkbox
class _FilterItem extends StatelessWidget {
  final String label;
  final dynamic value;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterItem({
    required this.label,
    required this.value,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.scale(20),
          vertical: context.scaleHeight(4),
        ),
        child: Row(
          children: [
            // Checkbox
            SizedBox(
              width: context.scale(28),
              height: context.scale(28),
              child: Checkbox(
                value: isSelected,
                onChanged: (_) => onTap(),
                activeColor: context.colors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.scale(4)),
                ),
              ),
            ),
            SizedBox(width: context.scale(12)),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: context.scaleFont(16),
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
