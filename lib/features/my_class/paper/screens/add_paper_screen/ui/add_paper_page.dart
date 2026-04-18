import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/di/injection.dart';
import '../../../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../../../core/widgets/app_app_bar.dart';
import '../../../../../../../core/widgets/app_dashed_upload_button.dart';
import '../../../../../../../core/widgets/app_dropdown_field.dart';
import '../../../../../../../core/widgets/app_primary_button.dart';
import '../../../../../../../cubit/theme_cubit.dart';
import '../bloc/add_paper_bloc.dart';

@RoutePage()
class AddPaperPage extends StatelessWidget implements AutoRouteWrapper {
  const AddPaperPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => AddPaperBloc(repository: sl.get()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface100,
      appBar: const AppAppBar(title: 'Add Exam Paper', showBackButton: true),
      body: BlocListener<AddPaperBloc, AddPaperState>(
        listenWhen: (prev, curr) =>
            prev.submitSuccess != curr.submitSuccess ||
            prev.error != curr.error,
        listener: (context, state) {
          if (state.submitSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Exam Paper added successfully')),
            );
            context.router.back();
          } else if (state.error != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error!)));
          }
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(context.scale(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _ClassDropdown(),
                    SizedBox(height: context.scaleHeight(16)),
                    _SectionDropdown(),
                    SizedBox(height: context.scaleHeight(16)),
                    _SubjectDropdown(),
                    SizedBox(height: context.scaleHeight(16)),
                    _PaperNameDropdown(),
                    SizedBox(height: context.scaleHeight(24)),

                    _UploadSection(),
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
    return BlocSelector<AddPaperBloc, AddPaperState, String?>(
      selector: (state) => state.selectedClass,
      builder: (context, value) {
        return AppDropdownField<String>(
          label: 'Class*',
          value: value,
          items: const ['Sr.KG', 'Jr.KG', '1st', '2nd', '3rd', '4th', '5th'],
          itemLabel: (item) => item,
          onChanged: (val) =>
              context.read<AddPaperBloc>().add(UpdatePaperClassEvent(val!)),
        );
      },
    );
  }
}

class _SectionDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddPaperBloc, AddPaperState, String?>(
      selector: (state) => state.section,
      builder: (context, value) {
        return AppDropdownField<String>(
          label: 'Section*',
          value: value,
          items: const ['A', 'B', 'C'],
          itemLabel: (item) => item,
          onChanged: (val) =>
              context.read<AddPaperBloc>().add(UpdatePaperSectionEvent(val!)),
        );
      },
    );
  }
}

class _SubjectDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddPaperBloc, AddPaperState, String?>(
      selector: (state) => state.subject,
      builder: (context, value) {
        return AppDropdownField<String>(
          label: 'Subject',
          value: value,
          items: const [
            'All Subjects',
            'English',
            'Science',
            'Mathematics',
            'Computer Science',
          ],
          itemLabel: (item) => item,
          onChanged: (val) =>
              context.read<AddPaperBloc>().add(UpdatePaperSubjectEvent(val!)),
        );
      },
    );
  }
}

class _PaperNameDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddPaperBloc, AddPaperState, String?>(
      selector: (state) => state.paperName,
      builder: (context, value) {
        return AppDropdownField<String>(
          label: 'Paper Name',
          value: value,
          items: const [
            'PT-1 EXAM PAPER',
            'PT-2 EXAM PAPER',
            'TERM-1 EXAM PAPER',
            'TERM-2 EXAM PAPER',
            'FINAL EXAM PAPER',
            'CH-WISE TEST PAPER',
          ],
          itemLabel: (item) => item,
          onChanged: (val) =>
              context.read<AddPaperBloc>().add(UpdatePaperNameEvent(val!)),
        );
      },
    );
  }
}

class _UploadSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddPaperBloc, AddPaperState, String?>(
      selector: (state) => state.pdfUrl,
      builder: (context, pdfUrl) {
        final isUploaded = pdfUrl != null;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppDashedUploadButton(
              icon: isUploaded
                  ? Icons.check_circle_outline
                  : Icons.cloud_upload_outlined,
              label: isUploaded
                  ? 'Exam Paper Uploaded'
                  : 'Upload Exam Paper PDF*',
              onTap: () {
                context.read<AddPaperBloc>().add(
                  const UpdatePaperPdfUrlEvent(
                    'https://www.aeee.in/wp-content/uploads/2020/08/Sample-pdf.pdf',
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Paper PDF Attached')),
                );
              },
            ),
            if (isUploaded)
              Padding(
                padding: EdgeInsets.only(top: context.scaleHeight(8)),
                child: Text(
                  'Attachment: exam_paper_document.pdf',
                  style: TextStyle(
                    fontSize: context.scaleFont(12),
                    color: context.colors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
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
            child: BlocSelector<AddPaperBloc, AddPaperState, bool>(
              selector: (state) => state.isSubmitting,
              builder: (context, isLoading) {
                return AppPrimaryButton(
                  text: 'SAVE PAPER',
                  isLoading: isLoading,
                  onPressed: () =>
                      context.read<AddPaperBloc>().add(SubmitPaperEvent()),
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
