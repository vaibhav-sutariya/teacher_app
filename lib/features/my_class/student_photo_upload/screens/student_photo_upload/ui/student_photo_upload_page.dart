import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';
import 'package:teachers_app/core/routes/app_router.gr.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import '../bloc/student_photo_upload_bloc.dart';
import '../../student_photo_list/ui/widgets/student_photo_class_card.dart';

@RoutePage()
class StudentPhotoUploadPage extends StatelessWidget {
  const StudentPhotoUploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentPhotoUploadBloc()
        ..add(LoadStudentPhotoClasses()),
      child: const _StudentPhotoUploadPageContent(),
    );
  }
}

class _StudentPhotoUploadPageContent extends StatelessWidget {
  const _StudentPhotoUploadPageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppAppBar(title: 'Student Photo Upload'),
      body: BlocBuilder<StudentPhotoUploadBloc, StudentPhotoUploadState>(
        builder: (context, state) {
          if (state.status == StudentPhotoUploadStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == StudentPhotoUploadStatus.error) {
            return Center(
              child: Text(state.errorMessage ?? 'Error Loading Classes'),
            );
          }

          if (state.classes.isEmpty) {
            return Center(
              child: Text(
                'No classes found',
                style: TextStyle(color: context.colors.textSecondary),
              ),
            );
          }

          return ListView.builder(
            itemCount: state.classes.length,
            itemBuilder: (context, index) {
              final classModel = state.classes[index];
              return StudentPhotoClassCard(
                classModel: classModel,
                onTap: () {
                  context.pushRoute(
                    StudentPhotoListRoute(className: classModel.className),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
