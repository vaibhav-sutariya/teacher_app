import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';
import 'package:teachers_app/core/widgets/month_calendar.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import '../bloc/new_admission_bloc.dart';
import '../../addmission_details_screen/ui/widgets/admission_date_item.dart';

@RoutePage()
class NewAdmissionPage extends StatelessWidget {
  const NewAdmissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NewAdmissionBloc()..add(LoadMonthAdmissions(DateTime(2025, 6, 1))),
      child: const _NewAdmissionPageContent(),
    );
  }
}

class _NewAdmissionPageContent extends StatelessWidget {
  const _NewAdmissionPageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppAppBar(title: 'New Admitted'),
      body: Column(
        children: [
          // Month Navigation
          const _CalendarSection(),

          // Summary Line
          const _SummarySection(),

          // Admission List
          const Expanded(child: _AdmissionList()),
        ],
      ),
    );
  }
}

class _CalendarSection extends StatelessWidget {
  const _CalendarSection();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<NewAdmissionBloc, NewAdmissionState, DateTime>(
      selector: (state) => state.selectedMonth,
      builder: (context, selectedMonth) {
        return MonthCalendar(
          selectedMonth: selectedMonth,
          onMonthChanged: (month) {
            context.read<NewAdmissionBloc>().add(ChangeAdmissionMonth(month));
          },
        );
      },
    );
  }
}

class _SummarySection extends StatelessWidget {
  const _SummarySection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.scale(20),
        vertical: context.scaleHeight(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocSelector<NewAdmissionBloc, NewAdmissionState, String?>(
            selector: (state) => state.errorMessage,
            builder: (context, error) {
              return Text(
                'New Admitted',
                style: TextStyle(
                  fontSize: context.scaleFont(14),
                  fontWeight: FontWeight.w500,
                  color: Colors.amber.shade700,
                ),
              );
            },
          ),
          BlocSelector<NewAdmissionBloc, NewAdmissionState, int>(
            selector: (state) => state.totalMonthAdmissions,
            builder: (context, total) {
              return Text(
                '$total',
                style: TextStyle(
                  fontSize: context.scaleFont(16),
                  fontWeight: FontWeight.bold,
                  color: Colors.amber.shade700,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _AdmissionList extends StatelessWidget {
  const _AdmissionList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewAdmissionBloc, NewAdmissionState>(
      buildWhen: (prev, curr) =>
          prev.status != curr.status || prev.admissions != curr.admissions,
      builder: (context, state) {
        if (state.status == NewAdmissionStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == NewAdmissionStatus.error) {
          return Center(
            child: Text(state.errorMessage ?? 'Error Loading Data'),
          );
        }

        if (state.admissions.isEmpty) {
          return Center(
            child: Text(
              'No admissions for this month',
              style: TextStyle(color: context.colors.textSecondary),
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: context.scaleHeight(10)),
          itemCount: state.admissions.length,
          itemBuilder: (context, index) {
            return AdmissionDateItem(admission: state.admissions[index]);
          },
        );
      },
    );
  }
}
