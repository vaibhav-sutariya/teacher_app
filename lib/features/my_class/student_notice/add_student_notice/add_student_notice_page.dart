import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../core/routes/app_router.gr.dart';
import '../../../../../core/widgets/app_app_bar.dart';
import '../../../../../core/widgets/app_dashed_upload_button.dart';
import '../../../../../core/widgets/app_dropdown_field.dart';
import '../../../../../core/widgets/app_primary_button.dart';
import '../../../../../core/widgets/app_text_field.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import 'bloc/add_student_notice_bloc.dart';
import 'bloc/add_student_notice_event.dart';
import 'bloc/add_student_notice_state.dart';

@RoutePage()
class AddStudentNoticePage extends StatelessWidget {
  const AddStudentNoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddStudentNoticeBloc(),
      child: const _AddStudentNoticeContent(),
    );
  }
}

class _AddStudentNoticeContent extends StatelessWidget {
  const _AddStudentNoticeContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppAppBar(
        title: 'Add Student Notice',
        backgroundColor: context.colors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.scale(20),
            vertical: context.scaleHeight(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Class & Section Row
              Row(
                children: [
                  Expanded(
                    child:
                        BlocSelector<
                          AddStudentNoticeBloc,
                          AddStudentNoticeState,
                          String?
                        >(
                          selector: (state) => state.selectedClass,
                          builder: (context, selectedClass) {
                            return AppDropdownField<String>(
                              isOutlined: true,
                              label: 'Class *',
                              hint: 'Select Class',
                              value: selectedClass,
                              items: const ['Class 1', 'Class 2', 'Class 3'],
                              itemLabel: (String v) => v,
                              onChanged: (val) {
                                if (val != null) {
                                  context.read<AddStudentNoticeBloc>().add(
                                    SelectClassEvent(val),
                                  );
                                }
                              },
                            );
                          },
                        ),
                  ),
                  SizedBox(width: context.scale(16)),
                  Expanded(
                    child:
                        BlocSelector<
                          AddStudentNoticeBloc,
                          AddStudentNoticeState,
                          String?
                        >(
                          selector: (state) => state.section,
                          builder: (context, section) {
                            return AppDropdownField<String>(
                              isOutlined: true,
                              label: 'Section *',
                              hint: 'Select Section',
                              value: section,
                              items: const ['A', 'B', 'C'],
                              itemLabel: (String v) => v,
                              onChanged: (val) {
                                if (val != null) {
                                  context.read<AddStudentNoticeBloc>().add(
                                    SelectSectionEvent(val),
                                  );
                                }
                              },
                            );
                          },
                        ),
                  ),
                ],
              ),
              SizedBox(height: context.scaleHeight(20)),

              // 2. Date Picker
              _SectionLabel('Date *'),
              SizedBox(height: context.scaleHeight(6)),
              BlocSelector<
                AddStudentNoticeBloc,
                AddStudentNoticeState,
                DateTime
              >(
                selector: (state) => state.date,
                builder: (context, date) {
                  return InkWell(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: context.colors.primary,
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (picked != null && context.mounted) {
                        context.read<AddStudentNoticeBloc>().add(
                          SelectDateEvent(picked),
                        );
                      }
                    },
                    borderRadius: BorderRadius.circular(context.scale(12)),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.scale(16),
                        vertical: context.scaleHeight(14),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: context.colors.border,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(context.scale(12)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat('dd/MM/yyyy').format(date),
                            style: TextStyle(
                              fontSize: context.scaleFont(14),
                              color: context.colors.textPrimary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(
                            Icons.calendar_today_outlined,
                            color: context.colors.primary,
                            size: context.scale(20),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: context.scaleHeight(20)),

              // 3. Title Field
              _SectionLabel('Notice Title *'),
              SizedBox(height: context.scaleHeight(6)),
              AppTextField(
                hintText: 'Enter title here',
                onChanged: (val) {
                  context.read<AddStudentNoticeBloc>().add(
                    UpdateTitleEvent(val),
                  );
                },
              ),
              SizedBox(height: context.scaleHeight(20)),

              // 4. Content Field
              _SectionLabel('Notice Content *'),
              SizedBox(height: context.scaleHeight(6)),
              AppTextField(
                hintText: 'Write notice details here',
                maxLines: 6,
                minLines: 4,
                onChanged: (val) {
                  context.read<AddStudentNoticeBloc>().add(
                    UpdateContentEvent(val),
                  );
                },
              ),
              SizedBox(height: context.scaleHeight(20)),

              // 5. Attachments
              _SectionLabel('Choose File'),
              SizedBox(height: context.scaleHeight(8)),
              Row(
                children: [
                  Expanded(
                    child: AppDashedUploadButton(
                      icon: Icons.image,
                      label: 'Image',
                      onTap: () {},
                    ),
                  ),
                  SizedBox(width: context.scale(16)),
                  Expanded(
                    child: AppDashedUploadButton(
                      icon: Icons.description,
                      label: 'Document',
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.scaleHeight(32)),

              // Error Display
              BlocSelector<
                AddStudentNoticeBloc,
                AddStudentNoticeState,
                String?
              >(
                selector: (state) => state.error,
                builder: (context, error) {
                  if (error == null) return const SizedBox.shrink();
                  return Padding(
                    padding: EdgeInsets.only(bottom: context.scaleHeight(16)),
                    child: Text(
                      error,
                      style: TextStyle(
                        color: context.colors.error,
                        fontSize: context.scaleFont(13),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),

              // 6. Next Button
              AppPrimaryButton(
                onPressed: () {
                  final blocState = context.read<AddStudentNoticeBloc>().state;
                  if (blocState.selectedClass == null ||
                      blocState.section == null ||
                      blocState.title.isEmpty ||
                      blocState.content.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill all required fields'),
                      ),
                    );
                    return;
                  }
                  context.router.push(
                    StudentNoticeStudentSelectionRoute(
                      className: blocState.selectedClass!,
                      section: blocState.section!,
                      addStudentNoticeBloc: context
                          .read<AddStudentNoticeBloc>(),
                    ),
                  );
                },
                text: 'NEXT',
                color: context.colors.primary,
                borderRadius: context.scale(12),
              ),
              SizedBox(height: context.scaleHeight(40)),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: context.scaleFont(14),
        fontWeight: FontWeight.w600,
        color: context.colors.surface600,
        letterSpacing: 0.3,
      ),
    );
  }
}
