import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../../../core/widgets/app_app_bar.dart';
import '../../../../../../../core/widgets/app_loader.dart';
import '../../../../../../../core/widgets/app_outlined_button.dart';
import '../../../../../../../core/widgets/app_primary_button.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import 'package:teachers_app/features/my_class/student_notice/screens/add_student_notice/bloc/add_student_notice_bloc.dart';
import 'package:teachers_app/features/my_class/student_notice/screens/add_student_notice/bloc/add_student_notice_event.dart';
import 'package:teachers_app/features/my_class/student_notice/screens/add_student_notice/bloc/add_student_notice_state.dart';

@RoutePage()
class StudentNoticeStudentSelectionPage extends StatelessWidget {
  final String className;
  final String section;
  final AddStudentNoticeBloc addStudentNoticeBloc;

  const StudentNoticeStudentSelectionPage({
    super.key,
    required this.className,
    required this.section,
    required this.addStudentNoticeBloc,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: addStudentNoticeBloc..add(LoadStudentsEvent()),
      child: _StudentSelectionContent(className: className, section: section),
    );
  }
}

class _StudentSelectionContent extends StatelessWidget {
  final String className;
  final String section;

  const _StudentSelectionContent({
    required this.className,
    required this.section,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddStudentNoticeBloc, AddStudentNoticeState>(
      listenWhen: (previous, current) =>
          previous.submitSuccess != current.submitSuccess,
      listener: (context, state) {
        if (state.submitSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Notice submitted successfully!')),
          );
          context.router.maybePopTop();
          context.router.maybePopTop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppAppBar(
          title: 'Select Students',
          backgroundColor: Colors.white,
          foregroundColor: context.colors.textPrimary,
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: context.scale(20),
                vertical: context.scaleHeight(16),
              ),
              color: context.colors.surface100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CLASS & SECTION',
                    style: TextStyle(
                      fontSize: context.scaleFont(11),
                      fontWeight: FontWeight.bold,
                      color: context.colors.primary,
                      letterSpacing: 1.0,
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(4)),
                  Text(
                    '$className - Section $section',
                    style: TextStyle(
                      fontSize: context.scaleFont(15),
                      fontWeight: FontWeight.bold,
                      color: context.colors.textPrimary,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.scale(20)),
                child: Column(
                  children: [
                    SizedBox(height: context.scaleHeight(16)),
                    TextFormField(
                      onChanged: (val) {
                        context.read<AddStudentNoticeBloc>().add(
                          SearchStudentsEvent(val),
                        );
                      },
                      style: TextStyle(
                        fontSize: context.scaleFont(14),
                        color: context.colors.textPrimary,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search students by name or roll no',
                        hintStyle: TextStyle(
                          fontSize: context.scaleFont(14),
                          color: context.colors.textTertiary,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: context.colors.primary.withValues(alpha: 0.7),
                        ),
                        filled: true,
                        fillColor: context.colors.surface100,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: context.scaleHeight(14),
                          horizontal: context.scale(16),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            context.scale(12),
                          ),
                          borderSide: BorderSide(
                            color: context.colors.border,
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            context.scale(12),
                          ),
                          borderSide: BorderSide(
                            color: context.colors.border,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            context.scale(12),
                          ),
                          borderSide: BorderSide(
                            color: context.colors.primary,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: context.scaleHeight(16)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BlocSelector<
                          AddStudentNoticeBloc,
                          AddStudentNoticeState,
                          int
                        >(
                          selector: (state) => state.selectedStudentIds.length,
                          builder: (context, count) {
                            return Text(
                              'Selected Students: $count',
                              style: TextStyle(
                                fontSize: context.scaleFont(13),
                                fontWeight: FontWeight.bold,
                                color: context.colors.primary,
                              ),
                            );
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<AddStudentNoticeBloc>().add(
                              ToggleSelectAllEvent(),
                            );
                          },
                          child:
                              BlocSelector<
                                AddStudentNoticeBloc,
                                AddStudentNoticeState,
                                bool
                              >(
                                selector: (state) {
                                  final filteredIds = state.filteredStudents
                                      .map((e) => e.id)
                                      .toSet();
                                  return filteredIds.isNotEmpty &&
                                      filteredIds.every(
                                        (id) => state.selectedStudentIds
                                            .contains(id),
                                      );
                                },
                                builder: (context, areAllSelected) {
                                  return Text(
                                    areAllSelected
                                        ? 'Deselect All'
                                        : 'Select All',
                                    style: TextStyle(
                                      fontSize: context.scaleFont(12),
                                      fontWeight: FontWeight.bold,
                                      color: context.colors.primary,
                                    ),
                                  );
                                },
                              ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.scaleHeight(16)),
                    Expanded(
                      child:
                          BlocBuilder<
                            AddStudentNoticeBloc,
                            AddStudentNoticeState
                          >(
                            builder: (context, state) {
                              if (state.isLoadingStudents) {
                                return Center(
                                  child: AppLoader(
                                    color: context.colors.primary,
                                  ),
                                );
                              }
                              if (state.filteredStudents.isEmpty) {
                                return const Center(
                                  child: Text('No students found.'),
                                );
                              }
                              return ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemCount: state.filteredStudents.length,
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: context.scaleHeight(16)),
                                itemBuilder: (context, index) {
                                  final student = state.filteredStudents[index];
                                  final isSelected = state.selectedStudentIds
                                      .contains(student.id);

                                  return GestureDetector(
                                    onTap: () {
                                      context.read<AddStudentNoticeBloc>().add(
                                        ToggleStudentSelectionEvent(student.id),
                                      );
                                    },
                                    child: Container(
                                      color: Colors.transparent,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  student.name,
                                                  style: TextStyle(
                                                    fontSize: context.scaleFont(
                                                      15,
                                                    ),
                                                    fontWeight: FontWeight.w600,
                                                    color: context
                                                        .colors
                                                        .textPrimary,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: context.scaleHeight(
                                                    4,
                                                  ),
                                                ),
                                                Text(
                                                  'Roll No: ${student.rollNo}',
                                                  style: TextStyle(
                                                    fontSize: context.scaleFont(
                                                      13,
                                                    ),
                                                    color: context
                                                        .colors
                                                        .textSecondary,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: context.scale(24),
                                            height: context.scale(24),
                                            decoration: BoxDecoration(
                                              color: isSelected
                                                  ? context.colors.primary
                                                  : Colors.white,
                                              border: Border.all(
                                                color: isSelected
                                                    ? context.colors.primary
                                                    : context.colors.border,
                                                width: 1.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    context.scale(6),
                                                  ),
                                            ),
                                            child: isSelected
                                                ? Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                    size: context.scale(16),
                                                  )
                                                : null,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.scale(20),
                vertical: context.scaleHeight(16),
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0A000000),
                    offset: Offset(0, -4),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  children: [
                    Expanded(
                      child: AppOutlinedButton(
                        onPressed: () {
                          context.router.maybePopTop();
                        },
                        text: 'CANCEL',
                        color: context.colors.primary,
                        side: BorderSide(
                          color: context.colors.primary,
                          width: 1.5,
                        ),
                        borderRadius: context.scale(12),
                      ),
                    ),
                    SizedBox(width: context.scale(16)),
                    Expanded(
                      child:
                          BlocSelector<
                            AddStudentNoticeBloc,
                            AddStudentNoticeState,
                            bool
                          >(
                            selector: (state) => state.isSubmitting,
                            builder: (context, isSubmitting) {
                              return AppPrimaryButton(
                                onPressed: () {
                                  final bloc = context
                                      .read<AddStudentNoticeBloc>();
                                  if (bloc.state.selectedStudentIds.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Please select at least one student.',
                                        ),
                                      ),
                                    );
                                    return;
                                  }
                                  bloc.add(SubmitNoticeEvent());
                                },
                                text: 'SUBMIT',
                                isLoading: isSubmitting,
                                color: context.colors.primary,
                                borderRadius: context.scale(12),
                              );
                            },
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
