import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import '../bloc/admission_details_bloc.dart';
import 'widgets/admission_class_item.dart';

@RoutePage()
class AdmissionDetailsPage extends StatelessWidget {
  final DateTime date;
  final int totalCount;

  const AdmissionDetailsPage({
    super.key,
    required this.date,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AdmissionDetailsBloc()..add(LoadDateAdmissions(date)),
      child: _AdmissionDetailsPageContent(date: date, totalCount: totalCount),
    );
  }
}

class _AdmissionDetailsPageContent extends StatelessWidget {
  final DateTime date;
  final int totalCount;

  const _AdmissionDetailsPageContent({
    required this.date,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppAppBar(title: 'New Admitted'),
      body: Column(
        children: [
          // Sub-header Info Row
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.scale(16),
              vertical: context.scaleHeight(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'New Admitted : $totalCount',
                  style: TextStyle(
                    fontSize: context.scaleFont(14),
                    fontWeight: FontWeight.w600,
                    color: Colors.amber.shade700,
                  ),
                ),
                Text(
                  DateFormat('dd-MMM-yyyy').format(date),
                  style: TextStyle(
                    fontSize: context.scaleFont(14),
                    fontWeight: FontWeight.w600,
                    color: Colors.amber.shade700,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Class-wise Breakdown List
          Expanded(
            child: BlocBuilder<AdmissionDetailsBloc, AdmissionDetailsState>(
              builder: (context, state) {
                if (state.status == AdmissionDetailsStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.status == AdmissionDetailsStatus.error) {
                  return Center(
                    child: Text(state.errorMessage ?? 'Error Loading Details'),
                  );
                }

                if (state.classAdmissions.isEmpty) {
                  return Center(
                    child: Text(
                      'No record for this day',
                      style: TextStyle(color: context.colors.textSecondary),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: state.classAdmissions.length,
                  itemBuilder: (context, index) {
                    return AdmissionClassItem(
                      admissionClass: state.classAdmissions[index],
                      date: date,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
