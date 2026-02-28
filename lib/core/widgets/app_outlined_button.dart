import 'package:flutter/material.dart';

class AppOutlinedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Widget? child;
  final Color? color;
  final bool fullWidth;
  final double height;
  final double borderRadius;
  final BorderSide? side;

  const AppOutlinedButton({
    super.key,
    required this.onPressed,
    this.text = '',
    this.child,
    this.color,
    this.fullWidth = true,
    this.height = 55,
    this.borderRadius = 16,
    this.side,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          side: side ?? BorderSide(color: color ?? theme.colorScheme.primary),
        ),
        child:
            child ??
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color:
                    color, // If null, inherits from OutlinedButton theme (Primary in Light, White in Dark)
              ),
            ),
      ),
    );
  }
}
