import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import 'bloc/student_notice_bloc.dart';
import 'widgets/student_notice_card.dart';

@RoutePage()
class StudentNoticePage extends StatelessWidget {
  const StudentNoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentNoticeBloc()..add(LoadStudentNotice()),
      child: Scaffold(
        backgroundColor: context.colors.surface,
        appBar: AppBar(
          backgroundColor: context.colors.primary,
          title: Text(
            'Student Notice',
            style: TextStyle(color: context.colors.textInverse),
          ),
          iconTheme: IconThemeData(color: context.colors.textInverse),
        ),
        body: BlocBuilder<StudentNoticeBloc, StudentNoticeState>(
          builder: (context, state) {
            if (state is StudentNoticeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is StudentNoticeLoaded) {
              return ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) => const StudentNoticeCard(),
              );
            } else if (state is StudentNoticeError) {
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
