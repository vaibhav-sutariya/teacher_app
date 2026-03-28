import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../core/routes/app_router.gr.dart';
import '../models/new_admission_model.dart';

class AdmissionDateItem extends StatelessWidget {
  final NewAdmissionModel admission;

  const AdmissionDateItem({super.key, required this.admission});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushRoute(
          AdmissionDetailsRoute(
            date: admission.date,
            totalCount: admission.admissionCount,
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.scale(24),
          vertical: context.scaleHeight(10),
        ),
        child: Row(
          children: [
            // Left: Colored Date Circle
            Container(
              width: context.scale(60),
              height: context.scale(60),
              decoration: BoxDecoration(
                color: admission.markerColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('dd').format(admission.date),
                    style: TextStyle(
                      fontSize: context.scaleFont(20),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.1,
                    ),
                  ),
                  Text(
                    DateFormat('MMM').format(admission.date),
                    style: TextStyle(
                      fontSize: context.scaleFont(12),
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: context.scale(20)),
            // Right: Admission Text
            Expanded(
              child: Text(
                'Admitted : ${admission.admissionCount}',
                style: TextStyle(
                  fontSize: context.scaleFont(18),
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
