import 'package:flutter/material.dart';

import '../../cubit/theme_cubit.dart';
import '../helpers/extensions/responsive_extensions.dart';

/// Reusable dropdown field widget
/// Features:
/// - Generic type support
/// - Custom item builder
/// - Validation support
/// - Consistent styling with text fields
/// - Optional outlined styling matching Remarks Entry screen
class AppDropdownField<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> items;
  final String Function(T) itemLabel;
  final ValueChanged<T?> onChanged;
  final String? Function(T?)? validator;
  final String hint;
  final bool enabled;
  final bool isOutlined;

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
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: isOutlined ? MainAxisSize.min : MainAxisSize.max,
      children: [
        if (label.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(
              bottom: context.scaleHeight(isOutlined ? 6 : 8),
            ),
            child: RichText(
              text: TextSpan(
                text: label,
                style: isOutlined
                    ? TextStyle(
                        fontSize: context.scaleFont(14),
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF4B5563),
                        letterSpacing: 0.3,
                      )
                    : TextStyle(
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
          elevation: isOutlined ? 1 : 8,
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(
                itemLabel(item),
                style: isOutlined
                    ? TextStyle(
                        fontSize: context.scaleFont(14),
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF111827),
                      )
                    : TextStyle(
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
            hintStyle: isOutlined
                ? TextStyle(
                    fontSize: context.scaleFont(14),
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF111827).withValues(alpha: 0.8),
                  )
                : TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
            fillColor: isOutlined ? Colors.white : const Color(0xFFF8F9FB),
            filled: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: context.scale(16),
              // Use specific vertical padding if outlined, else default matching text field
              vertical: isOutlined
                  ? context.scaleHeight(14)
                  : context.scaleHeight(0), // Provide a default or just omit
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                context.scale(isOutlined ? 12 : 16),
              ),
              borderSide: isOutlined
                  ? const BorderSide(color: Color(0xFFE5E7EB), width: 1.5)
                  : BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                context.scale(isOutlined ? 12 : 16),
              ),
              borderSide: isOutlined
                  ? const BorderSide(color: Color(0xFFE5E7EB), width: 1.5)
                  : BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                context.scale(isOutlined ? 12 : 16),
              ),
              borderSide: BorderSide(
                color: context.colors.primary,
                width: isOutlined ? 1.5 : 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                context.scale(isOutlined ? 12 : 16),
              ),
              borderSide: BorderSide(
                color: context.colors.error,
                width: isOutlined ? 1.5 : 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                context.scale(isOutlined ? 12 : 16),
              ),
              borderSide: BorderSide(
                color: context.colors.error,
                width: isOutlined ? 1.5 : 1,
              ),
            ),
          ),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: isOutlined ? const Color(0xFF006D44) : Colors.black87,
            size: context.scale(isOutlined ? 22 : 24),
          ),
          dropdownColor: Colors.white,
          isExpanded: true,
        ),
      ],
    );
  }
}
