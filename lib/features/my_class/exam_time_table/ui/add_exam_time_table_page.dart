import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../core/widgets/app_app_bar.dart';
import '../../../../../core/widgets/app_dashed_upload_button.dart';
import '../../../../../core/widgets/app_dropdown_field.dart';
import '../../../../../core/widgets/app_primary_button.dart';
import '../../../../../cubit/theme_cubit.dart';
import '../bloc/add_exam_time_table_bloc.dart';

@RoutePage()
class AddExamTimeTablePage extends StatelessWidget implements AutoRouteWrapper {
  const AddExamTimeTablePage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => AddExamTimeTableBloc(repository: sl.get()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface100,
      appBar: const AppAppBar(title: 'Add Exam Time Table', showBackButton: true),
      body: BlocListener<AddExamTimeTableBloc, AddExamTimeTableState>(
        listenWhen: (prev, curr) => prev.submitSuccess != curr.submitSuccess || prev.error != curr.error,
        listener: (context, state) {
          if (state.submitSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Exam Time Table added successfully')),
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _ClassDropdown(),
                    SizedBox(height: context.scaleHeight(16)),
                    _ExamNameDropdown(),
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
    return BlocSelector<AddExamTimeTableBloc, AddExamTimeTableState, String?>(
      selector: (state) => state.selectedClass,
      builder: (context, value) {
        return AppDropdownField<String>(
          label: 'Class*',
          value: value,
          items: const ['All Classes', 'Sr.KG', 'Jr.KG', '1st', '2nd', '3rd', '4th', '5th'],
          itemLabel: (item) => item,
          onChanged: (val) => context.read<AddExamTimeTableBloc>().add(UpdateExamTimeTableClassEvent(val!)),
        );
      },
    );
  }
}

class _ExamNameDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddExamTimeTableBloc, AddExamTimeTableState, String?>(
      selector: (state) => state.examName,
      builder: (context, value) {
        return AppDropdownField<String>(
          label: 'Exam Name*',
          value: value,
          items: const [
            'UNIT TEST-1 TIME TABLE',
            'UNIT TEST-2 TIME TABLE',
            'TERM-1 EXAM TIME TABLE',
            'TERM-2 EXAM TIME TABLE',
            'FINAL EXAM TIME TABLE',
            'PRE-BOARD TIME TABLE'
          ],
          itemLabel: (item) => item,
          onChanged: (val) => context.read<AddExamTimeTableBloc>().add(UpdateExamTimeTableNameEvent(val!)),
        );
      },
    );
  }
}

class _UploadSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddExamTimeTableBloc, AddExamTimeTableState, String?>(
      selector: (state) => state.pdfUrl,
      builder: (context, pdfUrl) {
        final isUploaded = pdfUrl != null;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppDashedUploadButton(
              icon: isUploaded ? Icons.check_circle_outline : Icons.cloud_upload_outlined,
              label: isUploaded ? 'Time Table Uploaded' : 'Upload Exam Time Table PDF*',
              onTap: () {
                context.read<AddExamTimeTableBloc>().add(
                  const UpdateExamTimeTablePdfUrlEvent('https://www.aeee.in/wp-content/uploads/2020/08/Sample-pdf.pdf'),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Time Table PDF Attached')),
                );
              },
            ),
            if (isUploaded)
              Padding(
                padding: EdgeInsets.only(top: context.scaleHeight(8)),
                child: Text(
                  'Attachment: exam_timetable_document.pdf',
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
            child: BlocSelector<AddExamTimeTableBloc, AddExamTimeTableState, bool>(
              selector: (state) => state.isSubmitting,
              builder: (context, isLoading) {
                return AppPrimaryButton(
                  text: 'SAVE TABLE',
                  isLoading: isLoading,
                  onPressed: () => context.read<AddExamTimeTableBloc>().add(SubmitExamTimeTableEvent()),
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
