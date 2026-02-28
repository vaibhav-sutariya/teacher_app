import 'package:flutter/material.dart';

import '../../cubit/theme_cubit.dart';
import '../helpers/extensions/responsive_extensions.dart';

/// Reusable dropdown field widget
/// Features:
/// - Generic type support
/// - Custom item builder
/// - Validation support
/// - Consistent styling with text fields
class AppDropdownField<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> items;
  final String Function(T) itemLabel;
  final ValueChanged<T?> onChanged;
  final String? Function(T?)? validator;
  final String hint;
  final bool enabled;

  const AppDropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
    this.validator,
    this.hint = 'Select an option',
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(bottom: context.scaleHeight(8)),
            child: RichText(
              text: TextSpan(
                text: label,
                style: TextStyle(
                  fontSize: context.scaleFont(14),
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                children: [
                  if (validator != null)
                    TextSpan(
                      text: ' *',
                      style: TextStyle(color: context.colors.error),
                    ),
                ],
              ),
            ),
          ),
        DropdownButtonFormField<T>(
          initialValue: value,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(
                itemLabel(item),
                style: TextStyle(
                  fontSize: context.scaleFont(14),
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            );
          }).toList(),
          onChanged: enabled ? onChanged : null,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            fillColor: const Color(0xFFF8F9FB),
            filled: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: context.scale(16),
              // vertical: context.scaleHeight(8),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(context.scale(16)),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(context.scale(16)),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(context.scale(16)),
              borderSide: BorderSide(color: context.colors.primary, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(context.scale(16)),
              borderSide: BorderSide(color: context.colors.error, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(context.scale(16)),
              borderSide: BorderSide(color: context.colors.error, width: 1),
            ),
          ),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.black87,
            size: context.scale(24),
          ),
          dropdownColor: Colors.white,
          isExpanded: true,
        ),
      ],
    );
  }
}
