import 'package:flutter/material.dart';

import '../../../../../core/helpers/extensions/responsive_extensions.dart';


/// Production-ready action required card widget
/// Optimized for performance with const constructor
class ActionRequiredCard extends StatelessWidget {
  final String title;
  final String description;

  const ActionRequiredCard({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.scale(16)),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEBEE),
        borderRadius: BorderRadius.circular(context.scale(12)),
      ),
      child: Stack(
        children: [
          // Background watermark
          Positioned(
            right: context.scale(-20),
            top: context.scale(-20),
            child: Opacity(
              opacity: 0.1,
              child: Text(
                '!',
                style: TextStyle(
                  fontSize: context.scale(120),
                  fontWeight: FontWeight.w900,
                  color: Colors.red[900],
                ),
              ),
            ),
          ),
          // Content
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(context.scale(8)),
                decoration: BoxDecoration(
                  color: const Color(0xFFE53935),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.info_outline,
                  color: Colors.white,
                  size: context.scale(20),
                ),
              ),
              SizedBox(width: context.scale(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: context.scaleFont(11),
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFE53935),
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: context.scaleHeight(4)),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: context.scaleFont(16),
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1A1A1A),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
