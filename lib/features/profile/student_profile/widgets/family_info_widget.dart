import 'package:flutter/material.dart';

import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../cubit/theme_cubit.dart';
import '../models/student_profile_model.dart';
import 'profile_info_card.dart';

class FamilyInfoWidget extends StatefulWidget {
  final FamilyInfo familyInfo;

  const FamilyInfoWidget({super.key, required this.familyInfo});

  @override
  State<FamilyInfoWidget> createState() => _FamilyInfoWidgetState();
}

class _FamilyInfoWidgetState extends State<FamilyInfoWidget> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);

  @override
  void dispose() {
    _selectedIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProfileInfoCard(
      title: 'Family Info',
      icon: Icons.family_restroom_rounded,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          // Tabs
          Container(
            padding: EdgeInsets.symmetric(vertical: context.scaleHeight(16)),
            color: context.colors.surface50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTab(0, 'Father', Icons.person_rounded),
                _buildTab(1, 'Mother', Icons.female_rounded),
                _buildTab(2, 'Guardian', Icons.people_alt_rounded),
                _buildTab(3, 'Sibling', Icons.face_rounded),
              ],
            ),
          ),
          // Content
          ValueListenableBuilder<int>(
            valueListenable: _selectedIndex,
            builder: (context, index, _) {
              return Padding(
                padding: EdgeInsets.all(context.scale(16)),
                child: _buildContent(index),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTab(int index, String label, IconData icon) {
    return ValueListenableBuilder<int>(
      valueListenable: _selectedIndex,
      builder: (context, selectedIndex, _) {
        final isSelected = selectedIndex == index;
        return InkWell(
          onTap: () => _selectedIndex.value = index,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.scale(12),
              vertical: context.scaleHeight(8),
            ),
            decoration: BoxDecoration(
              color: isSelected
                  ? context.colors.primary.withValues(alpha: 0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: context.scale(16),
                  backgroundColor: isSelected
                      ? context.colors.primary.withValues(alpha: 0.2)
                      : context.colors.surface200,
                  child: Icon(
                    icon,
                    size: context.scale(18),
                    color: isSelected
                        ? context.colors.primary
                        : context.colors.surface400,
                  ),
                ),
                SizedBox(height: context.scaleHeight(4)),
                Text(
                  label,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: isSelected
                        ? context.colors.primary
                        : context.colors.surface400,
                    fontWeight: FontWeight.w600,
                    fontSize: context.scaleFont(11),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent(int index) {
    switch (index) {
      case 0:
        return _buildDetails(
          name: widget.familyInfo.fatherName,
          occupation: widget.familyInfo.fatherOccupation,
          contact: widget.familyInfo.fatherContact,
        );
      case 1:
        return _buildDetails(
          name: widget.familyInfo.motherName,
          occupation: widget.familyInfo.motherOccupation,
          contact: widget.familyInfo.motherContact,
        );
      case 2:
        return _buildDetails(
          name: widget.familyInfo.guardianName,
          occupation: widget.familyInfo.guardianOccupation,
          contact: widget.familyInfo.guardianContact,
        );
      case 3:
        return _buildSiblingDetails(
          name: widget.familyInfo.siblingName,
          className: widget.familyInfo.siblingClass,
        );
      default:
        return const SizedBox();
    }
  }

  Widget _buildDetails({
    required String name,
    required String occupation,
    required String contact,
  }) {
    return Column(
      children: [
        _buildRow('Name', name, isBold: true),
        SizedBox(height: context.scaleHeight(12)),
        _buildRow('Occupation', occupation),
        SizedBox(height: context.scaleHeight(12)),
        _buildRow('Contact', contact, isBold: true),
      ],
    );
  }

  Widget _buildSiblingDetails({
    required String name,
    required String className,
  }) {
    return Column(
      children: [
        _buildRow('Name', name, isBold: true),
        SizedBox(height: context.scaleHeight(12)),
        _buildRow('Class', className),
      ],
    );
  }

  Widget _buildRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colors.surface400,
            fontSize: context.scaleFont(14),
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colors.surface900,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
              fontSize: context.scaleFont(14),
            ),
          ),
        ),
      ],
    );
  }
}
