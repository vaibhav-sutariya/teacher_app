import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';
import 'bloc/admitted_details_bloc.dart';
import 'widgets/admitted_student_card.dart';

@RoutePage()
class AdmittedDetailsPage extends StatelessWidget {
  final DateTime date;

  const AdmittedDetailsPage({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdmittedDetailsBloc()..add(LoadAdmittedDetails(date)),
      child: _AdmittedDetailsPageContent(date: date),
    );
  }
}

class _AdmittedDetailsPageContent extends StatelessWidget {
  final DateTime date;
  const _AdmittedDetailsPageContent({required this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface100,
      appBar: AppAppBar(
        title: 'Admitted Details (${DateFormat('dd-MM-yyyy').format(date)})',
        backgroundColor: context.colors.primary,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<AdmittedDetailsBloc, AdmittedDetailsState>(
        builder: (context, state) {
          if (state is AdmittedDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AdmittedDetailsLoaded) {
            if (state.students.isEmpty) {
              return const Center(child: Text('No details found for this date'));
            }
            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: context.scaleHeight(8)),
              itemCount: state.students.length,
              itemBuilder: (context, index) {
                return AdmittedStudentCard(student: state.students[index]);
              },
            );
          } else if (state is AdmittedDetailsError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
