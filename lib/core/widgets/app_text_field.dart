import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool autofocus;
  final Color? fillColor;
  final BorderSide? borderSide;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final Iterable<String>? autofillHints;
  final TextCapitalization textCapitalization;
  final int? maxLines;
  final int? minLines;
  final bool enabled;

  const AppTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.autofocus = false,
    this.fillColor,
    this.borderSide,
    this.validator,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
    this.autofillHints,
    this.textCapitalization = TextCapitalization.none,
    this.maxLines = 1,
    this.minLines,
    this.enabled = true,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputDecorationTheme = theme.inputDecorationTheme;

    // Standard Reference Color from NewPasswordPage: Color(0xFFF8F9FB)
    final effectiveColor =
        widget.fillColor ??
        inputDecorationTheme.fillColor ??
        context.colors.surface100;

    return TextFormField(
      key: _fieldKey,
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      textInputAction: widget.textInputAction,
      autofillHints: widget.autofillHints,
      textCapitalization: widget.textCapitalization,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      enabled: widget.enabled,
      onChanged: (value) {
        widget.onChanged?.call(value);
        if (widget.validator != null) {
          // Auto-validate on change if validator is present, mimicking text_field.dart behavior
          _fieldKey.currentState?.validate();
        }
      },
      onTap: widget.onTap,
      onFieldSubmitted: widget.onFieldSubmitted,
      validator: widget.validator,
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      style: theme.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        fillColor: effectiveColor,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        enabledBorder: widget.borderSide != null
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: widget.borderSide!,
              )
            : null, // Fallback to theme (which is now correctly standard)
        focusedBorder: widget.borderSide != null
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: widget.borderSide!.copyWith(
                  color: context.colors.primary,
                ),
              )
            : null,
        errorBorder: widget.borderSide != null
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: widget.borderSide!.copyWith(
                  color: context.colors.error,
                ),
              )
            : null, // Fallback to theme
        focusedErrorBorder: widget.borderSide != null
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: widget.borderSide!.copyWith(
                  color: theme.colorScheme.error,
                ),
              )
            : null, // Fallback to theme
      ),
    );
  }
}
