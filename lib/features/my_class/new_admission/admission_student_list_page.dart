import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import 'bloc/admission_student_list_bloc/admission_student_list_bloc.dart';
import 'widgets/admission_student_item.dart';

@RoutePage()
class AdmissionStudentListPage extends StatelessWidget {
  final String className;
  final DateTime date;

  const AdmissionStudentListPage({
    super.key,
    required this.className,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdmissionStudentListBloc()
        ..add(LoadClassAdmissions(className: className, date: date)),
      child: _AdmissionStudentListPageContent(className: className, date: date),
    );
  }
}

class _AdmissionStudentListPageContent extends StatelessWidget {
  final String className;
  final DateTime date;

  const _AdmissionStudentListPageContent({
    required this.className,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppAppBar(title: 'Details'),
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
                Expanded(
                  child: Text(
                    className,
                    style: TextStyle(
                      fontSize: context.scaleFont(14),
                      fontWeight: FontWeight.w600,
                      color: Colors.amber.shade700,
                    ),
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
          // Table Header
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.scale(16),
              vertical: context.scaleHeight(10),
            ),
            color: Colors.white,
            child: Row(
              children: [
                SizedBox(
                  width: context.scale(60),
                  child: Text(
                    'Roll No.',
                    style: TextStyle(
                      fontSize: context.scaleFont(13),
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(
                  width: context.scale(80),
                  child: Text(
                    'GR No.',
                    style: TextStyle(
                      fontSize: context.scaleFont(13),
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Name',
                    style: TextStyle(
                      fontSize: context.scaleFont(13),
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Student List
          Expanded(
            child: BlocBuilder<AdmissionStudentListBloc, AdmissionStudentListState>(
              builder: (context, state) {
                if (state.status == AdmissionStudentListStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.status == AdmissionStudentListStatus.error) {
                  return Center(
                    child: Text(state.errorMessage ?? 'Error Loading Students'),
                  );
                }

                if (state.students.isEmpty) {
                  return Center(
                    child: Text(
                      'No students found',
                      style: TextStyle(color: context.colors.textSecondary),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: state.students.length,
                  itemBuilder: (context, index) {
                    return AdmissionStudentItem(
                      student: state.students[index],
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
