import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import 'bloc/student_photo_upload_bloc.dart';
import 'widgets/student_photo_upload_card.dart';

@RoutePage()
class StudentPhotoUploadPage extends StatelessWidget {
  const StudentPhotoUploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          StudentPhotoUploadBloc()..add(LoadStudentPhotoUpload()),
      child: Scaffold(
        backgroundColor: context.colors.surface,
        appBar: AppBar(
          backgroundColor: context.colors.primary,
          title: Text(
            'Student Photo Upload',
            style: TextStyle(color: context.colors.textInverse),
          ),
          iconTheme: IconThemeData(color: context.colors.textInverse),
        ),
        body: BlocBuilder<StudentPhotoUploadBloc, StudentPhotoUploadState>(
          builder: (context, state) {
            if (state is StudentPhotoUploadLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is StudentPhotoUploadLoaded) {
              return ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) => const StudentPhotoUploadCard(),
              );
            } else if (state is StudentPhotoUploadError) {
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
