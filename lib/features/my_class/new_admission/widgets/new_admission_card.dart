import 'package:flutter/material.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

class NewAdmissionCard extends StatelessWidget {
  const NewAdmissionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colors.textInverse,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'New Admission Content',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: context.colors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Placeholder for new admission capabilities.',
              style: TextStyle(
                fontSize: 14,
                color: context.colors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
