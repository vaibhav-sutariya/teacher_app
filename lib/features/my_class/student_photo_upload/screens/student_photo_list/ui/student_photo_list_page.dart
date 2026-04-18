import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import '../bloc/student_photo_list_bloc.dart';
import '../../student_photo_upload/ui/widgets/photo_upload_bottom_sheet.dart';
import 'widgets/student_photo_item.dart';

@RoutePage()
class StudentPhotoListPage extends StatelessWidget {
  final String className;

  const StudentPhotoListPage({super.key, required this.className});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentPhotoListBloc()..add(LoadStudents(className)),
      child: _StudentPhotoListPageContent(className: className),
    );
  }
}

class _StudentPhotoListPageContent extends StatelessWidget {
  final String className;

  const _StudentPhotoListPageContent({required this.className});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppAppBar(
        title: 'Student List',
        actions: [
          Padding(
            padding: EdgeInsets.only(right: context.scale(16)),
            child: Row(
              children: [
                Text(
                  'All',
                  style: TextStyle(
                    fontSize: context.scaleFont(14),
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                  size: context.scale(20),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.all(context.scale(16)),
            child: TextField(
              onChanged: (value) {
                context.read<StudentPhotoListBloc>().add(SearchStudents(value));
              },
              decoration: InputDecoration(
                hintText: 'Search Student',
                prefixIcon: Icon(
                  Icons.search,
                  color: context.colors.textSecondary,
                ),
                filled: true,
                fillColor: Colors.grey.withValues(alpha: 0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(context.scale(12)),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: context.scaleHeight(10),
                ),
              ),
            ),
          ),
          // Student List
          Expanded(
            child: BlocBuilder<StudentPhotoListBloc, StudentPhotoListState>(
              builder: (context, state) {
                if (state.status == StudentPhotoListStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.status == StudentPhotoListStatus.error) {
                  return Center(
                    child: Text(state.errorMessage ?? 'Error Loading Students'),
                  );
                }

                if (state.filteredStudents.isEmpty) {
                  return Center(
                    child: Text(
                      'No record found',
                      style: TextStyle(color: context.colors.textSecondary),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: state.filteredStudents.length,
                  itemBuilder: (context, index) {
                    final student = state.filteredStudents[index];
                    return StudentPhotoItem(
                      student: student,
                      onTap: () {
                        showPhotoUploadBottomSheet(
                          context: context,
                          title: student.name,
                          photoUrl: student.photoUrl,
                          onCamera: () {
                            // Simulate upload
                            context.read<StudentPhotoListBloc>().add(
                              UpdateStudentPhoto(
                                studentId: student.id,
                                status: 'uploaded',
                              ),
                            );
                          },
                          onGallery: () {
                            // Simulate upload
                            context.read<StudentPhotoListBloc>().add(
                              UpdateStudentPhoto(
                                studentId: student.id,
                                status: 'uploaded',
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          // Summary Footer (as shown in image)
          Container(
            padding: EdgeInsets.symmetric(vertical: context.scaleHeight(12)),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Text(
              'SUMMARY',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.scaleFont(14),
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
