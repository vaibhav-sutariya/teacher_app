import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import '../../../student_photo_upload/screens/student_photo_upload/ui/widgets/photo_upload_bottom_sheet.dart';
import '../bloc/employee_photo_bloc/employee_photo_bloc.dart';
import 'widgets/employee_photo_item.dart';

@RoutePage()
class EmployeePhotoPage extends StatelessWidget {
  const EmployeePhotoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeePhotoBloc()..add(LoadEmployees()),
      child: const _EmployeePhotoPageContent(),
    );
  }
}

class _EmployeePhotoPageContent extends StatelessWidget {
  const _EmployeePhotoPageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppAppBar(title: 'Employee Photo'),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.all(context.scale(16)),
            child: TextField(
              onChanged: (value) {
                context.read<EmployeePhotoBloc>().add(SearchEmployees(value));
              },
              decoration: InputDecoration(
                hintText: 'Search Employee or Designation',
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
          // Employee List
          Expanded(
            child: BlocBuilder<EmployeePhotoBloc, EmployeePhotoState>(
              builder: (context, state) {
                if (state.status == EmployeePhotoStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.status == EmployeePhotoStatus.error) {
                  return Center(
                    child: Text(
                      state.errorMessage ?? 'Error Loading Employees',
                    ),
                  );
                }

                if (state.filteredEmployees.isEmpty) {
                  return const Center(child: Text('No employees found'));
                }

                return ListView.builder(
                  itemCount: state.filteredEmployees.length,
                  itemBuilder: (context, index) {
                    final employee = state.filteredEmployees[index];
                    return EmployeePhotoItem(
                      employee: employee,
                      onTap: () {
                        showPhotoUploadBottomSheet(
                          context: context,
                          title: employee.name,
                          photoUrl: employee.photoUrl,
                          onCamera: () {
                            context.read<EmployeePhotoBloc>().add(
                              UpdateEmployeePhoto(
                                employeeId: employee.id,
                                status: 'uploaded',
                              ),
                            );
                          },
                          onGallery: () {
                            context.read<EmployeePhotoBloc>().add(
                              UpdateEmployeePhoto(
                                employeeId: employee.id,
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
        ],
      ),
    );
  }
}
