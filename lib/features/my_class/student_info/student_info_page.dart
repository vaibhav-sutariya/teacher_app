import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import 'bloc/student_info_bloc.dart';
import 'widgets/student_info_card.dart';

@RoutePage()
class StudentInfoPage extends StatelessWidget {
  const StudentInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentInfoBloc()..add(LoadStudentInfo()),
      child: Scaffold(
        backgroundColor: context.colors.surface,
        appBar: AppBar(
          backgroundColor: context.colors.primary,
          title: Text(
            'Student Info',
            style: TextStyle(color: context.colors.textInverse),
          ),
          iconTheme: IconThemeData(color: context.colors.textInverse),
        ),
        body: BlocBuilder<StudentInfoBloc, StudentInfoState>(
          builder: (context, state) {
            if (state is StudentInfoLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is StudentInfoLoaded) {
              return ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) => const StudentInfoCard(),
              );
            } else if (state is StudentInfoError) {
              return Center(
                child: Text(
                  state.message,
                  style: TextStyle(color: context.colors.error),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
