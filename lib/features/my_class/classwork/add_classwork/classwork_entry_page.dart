import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';
import 'package:teachers_app/core/widgets/app_dashed_upload_button.dart';
import 'package:teachers_app/core/widgets/app_primary_button.dart';
import 'package:teachers_app/core/widgets/app_text_field.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import 'bloc/classwork_entry_bloc.dart';
import 'bloc/classwork_entry_event.dart';
import 'bloc/classwork_entry_state.dart';

@RoutePage()
class ClassworkEntryPage extends StatelessWidget {
  final String className;
  final DateTime selectedDate;
  final String subjectName;

  const ClassworkEntryPage({
    super.key,
    required this.className,
    required this.selectedDate,
    required this.subjectName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClassworkEntryBloc(),
      child: _ClassworkEntryContent(
        className: className,
        selectedDate: selectedDate,
        subjectName: subjectName,
      ),
    );
  }
}

class _ClassworkEntryContent extends StatelessWidget {
  final String className;
  final DateTime selectedDate;
  final String subjectName;

  const _ClassworkEntryContent({
    required this.className,
    required this.selectedDate,
    required this.subjectName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppAppBar(title: 'Class Work Entry'),
      body: BlocListener<ClassworkEntryBloc, ClassworkEntryState>(
        listener: (context, state) {
          if (state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Classwork submitted successfully!'),
              ),
            );
            context.router.maybePopTop();
          }
          if (state.error != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error!)));
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: context.scale(20),
            vertical: context.scaleHeight(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Class and Date Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    className.toUpperCase(),
                    style: TextStyle(
                      color: context.colors.primary,
                      fontSize: context.scaleFont(14),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat('dd-MMM-yyyy').format(selectedDate),
                    style: TextStyle(
                      color: context.colors.primary,
                      fontSize: context.scaleFont(14),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.scaleHeight(20)),
              Divider(color: context.colors.divider, height: 1),
              SizedBox(height: context.scaleHeight(20)),

              // Classwork Content
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _SectionLabel('Classwork Content', isRequired: true),
                  Text(
                    subjectName.toUpperCase(),
                    style: TextStyle(
                      fontSize: context.scaleFont(14),
                      fontWeight: FontWeight.bold,
                      color: context.colors.primary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.scaleHeight(12)),
              AppTextField(
                hintText: 'Write Your Content',
                maxLines: 8,
                minLines: 5,
                onChanged: (val) {
                  context.read<ClassworkEntryBloc>().add(
                    ClassworkContentChanged(val),
                  );
                },
              ),
              SizedBox(height: context.scaleHeight(24)),

              // Attachment
              _SectionLabel('Attachment'),
              SizedBox(height: context.scaleHeight(12)),
              Row(
                children: [
                  Expanded(
                    child: AppDashedUploadButton(
                      icon: Icons.image,
                      label: 'Image',
                      onTap: () {
                        // TODO: Implement image picker
                      },
                    ),
                  ),
                  SizedBox(width: context.scale(16)),
                  Expanded(
                    child: AppDashedUploadButton(
                      icon: Icons.description,
                      label: 'Document',
                      onTap: () {
                        // TODO: Implement document picker
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.scaleHeight(40)),

              // Submit Button
              BlocBuilder<ClassworkEntryBloc, ClassworkEntryState>(
                builder: (context, state) {
                  return AppPrimaryButton(
                    onPressed: state.isSubmitting
                        ? null
                        : () {
                            context.read<ClassworkEntryBloc>().add(
                              SubmitClassworkEvent(),
                            );
                          },
                    text: state.isSubmitting ? 'SUBMITTING...' : 'SUBMIT',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  final bool isRequired;

  const _SectionLabel(this.text, {this.isRequired = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: context.scaleFont(14),
            fontWeight: FontWeight.w600,
            color: context.colors.textPrimary,
          ),
        ),
        if (isRequired)
          Text(
            '*',
            style: TextStyle(
              fontSize: context.scaleFont(14),
              fontWeight: FontWeight.w600,
              color: Colors.red,
            ),
          ),
      ],
    );
  }
}
