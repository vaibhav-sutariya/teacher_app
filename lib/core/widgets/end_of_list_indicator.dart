import 'package:flutter/material.dart';

import '../helpers/extensions/responsive_extensions.dart';

/// Reusable end of list indicator widget
/// Shows "You reached at the end" message with a divider
/// Optimized for performance with RepaintBoundary
class EndOfListIndicator extends StatelessWidget {
  final EdgeInsets? padding;
  final String? message;
  final double? dividerIndent;

  const EndOfListIndicator({
    super.key,
    this.padding,
    this.message,
    this.dividerIndent,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Padding(
        padding: padding ?? EdgeInsets.all(context.scaleHeight(24)),
        child: Column(
          children: [
            Text(
              message ?? 'You reached at the end',
              style: TextStyle(
                fontSize: context.scaleFont(12),
                color: Colors.grey[500],
              ),
            ),
            SizedBox(height: context.scaleHeight(8)),
            Divider(
              color: Colors.grey[300],
              thickness: 1,
              indent: dividerIndent ?? context.scale(40),
              endIndent: dividerIndent ?? context.scale(40),
            ),
          ],
        ),
      ),
    );
  }
}
