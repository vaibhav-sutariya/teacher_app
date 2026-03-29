import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';
import 'package:teachers_app/core/widgets/app_dashed_upload_button.dart';
import 'package:teachers_app/core/widgets/app_primary_button.dart';
import 'package:teachers_app/core/widgets/app_text_field.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import 'bloc/add_staff_notice_bloc.dart';

@RoutePage()
class AddStaffNoticePage extends StatelessWidget {
  const AddStaffNoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddStaffNoticeBloc(),
      child: const _AddStaffNoticeContent(),
    );
  }
}

class _AddStaffNoticeContent extends StatelessWidget {
  const _AddStaffNoticeContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppAppBar(title: 'Add Staff Notice'),
      body: BlocListener<AddStaffNoticeBloc, AddStaffNoticeState>(
        listener: (context, state) {
          if (state.status == AddStaffNoticeStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Notice added successfully')),
            );
            context.router.pop(true);
          } else if (state.status == AddStaffNoticeStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error ?? 'Something went wrong')),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.scale(20),
              vertical: context.scaleHeight(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Date Picker
                _SectionLabel('Date *'),
                SizedBox(height: context.scaleHeight(6)),
                BlocBuilder<AddStaffNoticeBloc, AddStaffNoticeState>(
                  buildWhen: (p, c) => p.date != c.date,
                  builder: (context, state) {
                    return InkWell(
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: state.date,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: context.colors.warning,
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (picked != null && context.mounted) {
                          context.read<AddStaffNoticeBloc>().add(
                            UpdateStaffNoticeDate(picked),
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
                          borderRadius: BorderRadius.circular(
                            context.scale(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat('dd/MM/yyyy').format(state.date),
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

                // 2. Title Field
                _SectionLabel('Notice Title *'),
                SizedBox(height: context.scaleHeight(6)),
                AppTextField(
                  hintText: 'Enter title here',
                  onChanged: (val) {
                    context.read<AddStaffNoticeBloc>().add(
                      UpdateStaffNoticeTitle(val),
                    );
                  },
                ),
                SizedBox(height: context.scaleHeight(20)),

                // 3. Content Field
                _SectionLabel('Notice Content *'),
                SizedBox(height: context.scaleHeight(6)),
                AppTextField(
                  hintText: 'Write notice details here',
                  maxLines: 6,
                  minLines: 4,
                  onChanged: (val) {
                    context.read<AddStaffNoticeBloc>().add(
                      UpdateStaffNoticeContent(val),
                    );
                  },
                ),
                SizedBox(height: context.scaleHeight(20)),

                // 4. Attachments
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

                // 5. Submit Button
                BlocBuilder<AddStaffNoticeBloc, AddStaffNoticeState>(
                  builder: (context, state) {
                    return AppPrimaryButton(
                      onPressed: state.status == AddStaffNoticeStatus.submitting
                          ? null
                          : () {
                              context.read<AddStaffNoticeBloc>().add(
                                SubmitStaffNotice(),
                              );
                            },
                      text: state.status == AddStaffNoticeStatus.submitting
                          ? 'SUBMITTING...'
                          : 'SUBMIT',
                      borderRadius: context.scale(12),
                    );
                  },
                ),
                SizedBox(height: context.scaleHeight(40)),
              ],
            ),
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
