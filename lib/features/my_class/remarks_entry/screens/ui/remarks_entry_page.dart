import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../../core/routes/app_router.gr.dart';
import '../../../../../../core/widgets/app_app_bar.dart';
import '../../../../../../core/widgets/app_dashed_upload_button.dart';
import '../../../../../../core/widgets/app_dropdown_field.dart';
import '../../../../../../core/widgets/app_primary_button.dart';
import '../bloc/remarks_entry_bloc.dart';
import '../bloc/remarks_entry_event.dart';
import '../bloc/remarks_entry_state.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

@RoutePage()
class RemarksEntryPage extends StatelessWidget {
  const RemarksEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RemarksEntryBloc(),
      child: const _RemarksEntryContent(),
    );
  }
}

class _RemarksEntryContent extends StatelessWidget {
  const _RemarksEntryContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppAppBar(
        title: 'Remarks Entry',
        backgroundColor: context.colors.primary, // Dark Green
        foregroundColor: Colors.white,
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
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
                              RemarksEntryBloc,
                              RemarksEntryState,
                              String?
                            >(
                              selector: (state) => state.selectedClass,
                              builder: (context, selectedClass) {
                                return AppDropdownField<String>(
                                  isOutlined: true,
                                  label: 'Class',
                                  hint: 'Select Class',
                                  value: selectedClass,
                                  items: const [
                                    'Class 1',
                                    'Class 2',
                                    'Class 3',
                                  ],
                                  itemLabel: (String v) => v,
                                  onChanged: (val) {
                                    if (val != null) {
                                      context.read<RemarksEntryBloc>().add(
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
                              RemarksEntryBloc,
                              RemarksEntryState,
                              String?
                            >(
                              selector: (state) => state.section,
                              builder: (context, section) {
                                return AppDropdownField<String>(
                                  isOutlined: true,
                                  label: 'Section',
                                  hint: 'Select Section',
                                  value: section,
                                  items: const ['A', 'B', 'C'],
                                  itemLabel: (String v) => v,
                                  onChanged: (val) {
                                    if (val != null) {
                                      context.read<RemarksEntryBloc>().add(
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

                  // 2. Date Picker Field
                  _SectionLabel('Date'),
                  SizedBox(height: context.scaleHeight(6)),
                  BlocSelector<RemarksEntryBloc, RemarksEntryState, DateTime>(
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
                            context.read<RemarksEntryBloc>().add(
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
                            borderRadius: BorderRadius.circular(
                              context.scale(12),
                            ),
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

                  // 3. Category Dropdown
                  BlocSelector<RemarksEntryBloc, RemarksEntryState, String?>(
                    selector: (state) => state.category,
                    builder: (context, category) {
                      return AppDropdownField<String>(
                        isOutlined: true,
                        label: 'Remarks Category',
                        hint: 'Select Category',
                        value: category,
                        items: const [
                          'Discipline',
                          'Academics',
                          'Extracurricular',
                        ],
                        itemLabel: (String v) => v,
                        onChanged: (val) {
                          if (val != null) {
                            context.read<RemarksEntryBloc>().add(
                              SelectCategoryEvent(val),
                            );
                          }
                        },
                      );
                    },
                  ),
                  SizedBox(height: context.scaleHeight(20)),

                  // 4. Name Dropdown
                  BlocSelector<RemarksEntryBloc, RemarksEntryState, String?>(
                    selector: (state) => state.remarkName,
                    builder: (context, remarkName) {
                      return AppDropdownField<String>(
                        isOutlined: true,
                        label: 'Remark Name',
                        hint: 'Select Name',
                        value: remarkName,
                        items: const [
                          'Late Arrival',
                          'Homework Not Done',
                          'Excellent Work',
                        ],
                        itemLabel: (String v) => v,
                        onChanged: (val) {
                          if (val != null) {
                            context.read<RemarksEntryBloc>().add(
                              SelectRemarkNameEvent(val),
                            );
                          }
                        },
                      );
                    },
                  ),
                  SizedBox(height: context.scaleHeight(20)),

                  // 5. Type Dropdown
                  BlocSelector<RemarksEntryBloc, RemarksEntryState, String?>(
                    selector: (state) => state.remarkType,
                    builder: (context, remarkType) {
                      return AppDropdownField<String>(
                        isOutlined: true,
                        label: 'Remark Type',
                        hint: 'Select Type',
                        value: remarkType,
                        items: const ['Warning', 'Positive', 'Informative'],
                        itemLabel: (String v) => v,
                        onChanged: (val) {
                          if (val != null) {
                            context.read<RemarksEntryBloc>().add(
                              SelectRemarkTypeEvent(val),
                            );
                          }
                        },
                      );
                    },
                  ),
                  SizedBox(height: context.scaleHeight(20)),

                  // 6. Note Area
                  _SectionLabel('Note'),
                  SizedBox(height: context.scaleHeight(6)),
                  TextFormField(
                    maxLines: 4,
                    onChanged: (val) {
                      context.read<RemarksEntryBloc>().add(
                        UpdateNoteEvent(val),
                      );
                    },
                    style: TextStyle(
                      fontSize: context.scaleFont(14),
                      color: context.colors.textPrimary,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Write your comment',
                      hintStyle: TextStyle(
                        fontSize: context.scaleFont(14),
                        color: context.colors.textSecondary,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.all(context.scale(16)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(context.scale(12)),
                        borderSide: BorderSide(
                          color: context.colors.border,
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(context.scale(12)),
                        borderSide: BorderSide(
                          color: context.colors.border,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(context.scale(12)),
                        borderSide: BorderSide(
                          color: context.colors.primary,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(20)),

                  // 7. Choose File
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
                  SizedBox(height: context.scaleHeight(20)),

                  // 8. SMS Content
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _SectionLabel('SMS Content'),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.scale(8),
                          vertical: context.scaleHeight(4),
                        ),
                        decoration: BoxDecoration(
                          color:
                              context.colors.successLight, // Light Green Base
                          borderRadius: BorderRadius.circular(
                            context.scale(12),
                          ),
                        ),
                        child: Text(
                          'AUTO-GENERATED',
                          style: TextStyle(
                            fontSize: context.scaleFont(10),
                            fontWeight: FontWeight.bold,
                            color: context.colors.primary,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.scaleHeight(6)),
                  Container(
                    padding: EdgeInsets.all(context.scale(16)),
                    decoration: BoxDecoration(
                      color: context.colors.surface100,
                      borderRadius: BorderRadius.circular(context.scale(12)),
                      border: Border.all(color: context.colors.border),
                    ),
                    child: Text(
                      'Dear Parent, your ward has received a new remark regarding their performance. Please check the portal for details.',
                      style: TextStyle(
                        fontSize: context.scaleFont(14),
                        fontStyle: FontStyle.italic,
                        color: context.colors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(32)),

                  // 9. Next Button
                  AppPrimaryButton(
                    onPressed: () {
                      final blocState = context.read<RemarksEntryBloc>().state;
                      if (blocState.category == null ||
                          blocState.remarkName == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please select category and name first',
                            ),
                          ),
                        );
                        return;
                      }
                      context.router.push(
                        RemarksStudentSelectionRoute(
                          remarkCategory: blocState.category!,
                          remarkName: blocState.remarkName!,
                          remarksEntryBloc: context.read<RemarksEntryBloc>(),
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
        ],
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
