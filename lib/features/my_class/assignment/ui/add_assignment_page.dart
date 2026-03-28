import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../core/widgets/app_app_bar.dart';
import '../../../../core/widgets/app_dropdown_field.dart';
import '../../../../core/widgets/app_primary_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../cubit/theme_cubit.dart';
import '../bloc/add_assignment_bloc.dart';
import '../models/assignment_model.dart';

@RoutePage()
class AddAssignmentPage extends StatelessWidget implements AutoRouteWrapper {
  const AddAssignmentPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => AddAssignmentBloc(repository: sl.get()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface100,
      appBar: AppAppBar(
        title: 'Assignment Entry',
        showBackButton: true,
        actions: [
          _SmsToggle(),
        ],
      ),
      body: BlocListener<AddAssignmentBloc, AddAssignmentState>(
        listenWhen: (prev, curr) => prev.submitSuccess != curr.submitSuccess || prev.error != curr.error,
        listener: (context, state) {
          if (state.submitSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Assignment added successfully')),
            );
            context.router.back();
          } else if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error!)),
            );
          }
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(context.scale(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ClassDropdown(),
                    SizedBox(height: context.scaleHeight(16)),
                    _SectionDropdown(),
                    SizedBox(height: context.scaleHeight(16)),
                    _SubjectDropdown(),
                    SizedBox(height: context.scaleHeight(16)),
                    _LessonDropdown(),
                    SizedBox(height: context.scaleHeight(16)),
                    _TopicDropdown(),
                    SizedBox(height: context.scaleHeight(24)),
                    
                    Text(
                      'Attachment*',
                      style: TextStyle(
                        fontSize: context.scaleFont(14),
                        fontWeight: FontWeight.w500,
                        color: context.colors.textSecondary,
                      ),
                    ),
                    SizedBox(height: context.scaleHeight(8)),
                    _AttachmentSelector(),
                    SizedBox(height: context.scaleHeight(24)),
                    
                    _DescriptionField(),
                    SizedBox(height: context.scaleHeight(32)),
                  ],
                ),
              ),
            ),
            _FooterButtons(),
          ],
        ),
      ),
    );
  }
}

class _ClassDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddAssignmentBloc, AddAssignmentState, String?>(
      selector: (state) => state.selectedClass,
      builder: (context, value) {
        return AppDropdownField<String>(
          label: 'Class*',
          value: value,
          items: const ['10th', '9th', '8th'],
          itemLabel: (item) => item,
          onChanged: (val) => context.read<AddAssignmentBloc>().add(UpdateClassEvent(val!)),
        );
      },
    );
  }
}

class _SectionDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddAssignmentBloc, AddAssignmentState, String?>(
      selector: (state) => state.section,
      builder: (context, value) {
        return AppDropdownField<String>(
          label: 'Section*',
          value: value,
          items: const ['A', 'B', 'C'],
          itemLabel: (item) => item,
          onChanged: (val) => context.read<AddAssignmentBloc>().add(UpdateSectionEvent(val!)),
        );
      },
    );
  }
}

class _SubjectDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddAssignmentBloc, AddAssignmentState, String?>(
      selector: (state) => state.subject,
      builder: (context, value) {
        return AppDropdownField<String>(
          label: 'Subject',
          value: value,
          items: const ['Mathematics', 'Science', 'English'],
          itemLabel: (item) => item,
          onChanged: (val) => context.read<AddAssignmentBloc>().add(UpdateSubjectEvent(val!)),
        );
      },
    );
  }
}

class _LessonDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddAssignmentBloc, AddAssignmentState, String?>(
      selector: (state) => state.lesson,
      builder: (context, value) {
        return AppDropdownField<String>(
          label: 'Lesson',
          value: value,
          items: const ['Chapter 1', 'Chapter 2', 'Chapter 3'],
          itemLabel: (item) => item,
          onChanged: (val) => context.read<AddAssignmentBloc>().add(UpdateLessonEvent(val!)),
        );
      },
    );
  }
}

class _TopicDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddAssignmentBloc, AddAssignmentState, String?>(
      selector: (state) => state.topic,
      builder: (context, value) {
        return AppDropdownField<String>(
          label: 'Topic',
          value: value,
          items: const ['Introduction', 'Advanced', 'Revision'],
          itemLabel: (item) => item,
          onChanged: (val) => context.read<AddAssignmentBloc>().add(UpdateTopicEvent(val!)),
        );
      },
    );
  }
}

class _AttachmentSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddAssignmentBloc, AddAssignmentState, AttachmentType>(
      selector: (state) => state.attachmentType,
      builder: (context, selectedType) {
        return Container(
          height: context.scaleHeight(50),
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(context.scale(12)),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              _Option('Image', AttachmentType.image, selectedType),
              Container(width: 1, color: Colors.grey.withValues(alpha: 0.2)),
              _Option('Document', AttachmentType.document, selectedType),
            ],
          ),
        );
      },
    );
  }
}

class _Option extends StatelessWidget {
  final String label;
  final AttachmentType type;
  final AttachmentType currentType;
  const _Option(this.label, this.type, this.currentType);

  @override
  Widget build(BuildContext context) {
    final isSelected = type == currentType;
    return Expanded(
      child: GestureDetector(
        onTap: () => context.read<AddAssignmentBloc>().add(UpdateAttachmentTypeEvent(type)),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? context.colors.primary.withValues(alpha: 0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(context.scale(12)),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? context.colors.primary : context.colors.textSecondary,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

class _DescriptionField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppTextField(
      labelText: 'Description',
      maxLines: 4,
      hintText: 'Enter assignment details...',
      onChanged: (val) => context.read<AddAssignmentBloc>().add(UpdateDescriptionEvent(val)),
    );
  }
}

class _SmsToggle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddAssignmentBloc, AddAssignmentState, bool>(
      selector: (state) => state.isSmsEnabled,
      builder: (context, isEnabled) {
        return Container(
          margin: EdgeInsets.only(right: context.scale(8)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    isEnabled ? 'Yes' : 'No',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: context.scaleFont(12),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Switch(
                    value: isEnabled,
                    onChanged: (val) => context.read<AddAssignmentBloc>().add(ToggleSmsEvent(val)),
                    activeColor: Colors.white,
                    activeTrackColor: context.colors.primary2nd,
                    inactiveThumbColor: Colors.white70,
                    inactiveTrackColor: Colors.white24,
                  ),
                ],
              ),
              Text(
                'SEND SMS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: context.scaleFont(10),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FooterButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.scale(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: BlocSelector<AddAssignmentBloc, AddAssignmentState, bool>(
              selector: (state) => state.isSubmitting,
              builder: (context, isLoading) {
                return AppPrimaryButton(
                  text: 'SUBMIT',
                  isLoading: isLoading,
                  onPressed: () => context.read<AddAssignmentBloc>().add(SubmitAssignmentEvent()),
                );
              },
            ),
          ),
          SizedBox(width: context.scale(16)),
          Expanded(
            child: AppPrimaryButton(
              text: 'CANCEL',
              color: context.colors.error,
              onPressed: () => context.router.back(),
            ),
          ),
        ],
      ),
    );
  }
}
