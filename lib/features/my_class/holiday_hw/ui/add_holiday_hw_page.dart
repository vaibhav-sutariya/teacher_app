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
import '../bloc/add_holiday_hw_bloc.dart';

@RoutePage()
class AddHolidayHwPage extends StatelessWidget implements AutoRouteWrapper {
  const AddHolidayHwPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => AddHolidayHwBloc(repository: sl.get()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface100,
      appBar: const AppAppBar(title: 'Add Holiday Homework', showBackButton: true),
      body: BlocListener<AddHolidayHwBloc, AddHolidayHwState>(
        listenWhen: (prev, curr) => prev.submitSuccess != curr.submitSuccess || prev.error != curr.error,
        listener: (context, state) {
          if (state.submitSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Holiday Homework added successfully')),
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
                    _SectionDropdown(),
                    SizedBox(height: context.scaleHeight(16)),
                    _SubjectDropdown(),
                    SizedBox(height: context.scaleHeight(16)),
                    _HWTypeDropdown(),
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
    return BlocSelector<AddHolidayHwBloc, AddHolidayHwState, String?>(
      selector: (state) => state.selectedClass,
      builder: (context, value) {
        return AppDropdownField<String>(
          label: 'Class*',
          value: value,
          items: const ['Sr.KG', 'Jr.KG', '1st', '2nd', '3rd', '4th', '5th'],
          itemLabel: (item) => item,
          onChanged: (val) => context.read<AddHolidayHwBloc>().add(UpdateHolidayHwClassEvent(val!)),
        );
      },
    );
  }
}

class _SectionDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddHolidayHwBloc, AddHolidayHwState, String?>(
      selector: (state) => state.section,
      builder: (context, value) {
        return AppDropdownField<String>(
          label: 'Section*',
          value: value,
          items: const ['A', 'B', 'C'],
          itemLabel: (item) => item,
          onChanged: (val) => context.read<AddHolidayHwBloc>().add(UpdateHolidayHwSectionEvent(val!)),
        );
      },
    );
  }
}

class _SubjectDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddHolidayHwBloc, AddHolidayHwState, String?>(
      selector: (state) => state.subject,
      builder: (context, value) {
        return AppDropdownField<String>(
          label: 'Subject',
          value: value,
          items: const ['All Subjects', 'English', 'Science', 'Mathematics', 'Computer Science'],
          itemLabel: (item) => item,
          onChanged: (val) => context.read<AddHolidayHwBloc>().add(UpdateHolidayHwSubjectEvent(val!)),
        );
      },
    );
  }
}

class _HWTypeDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddHolidayHwBloc, AddHolidayHwState, String?>(
      selector: (state) => state.hwName,
      builder: (context, value) {
        return AppDropdownField<String>(
          label: 'HW Name (Type)',
          value: value,
          items: const [
            'SUMMER VACATION HW',
            'DIWALI VACATION HW',
            'WINTER BREAK HW',
            'EID HOLIDAY HW',
            'CHRISTMAS HW'
          ],
          itemLabel: (item) => item,
          onChanged: (val) => context.read<AddHolidayHwBloc>().add(UpdateHolidayHwNameEvent(val!)),
        );
      },
    );
  }
}

class _UploadSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddHolidayHwBloc, AddHolidayHwState, String?>(
      selector: (state) => state.pdfUrl,
      builder: (context, pdfUrl) {
        final isUploaded = pdfUrl != null;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppDashedUploadButton(
              icon: isUploaded ? Icons.check_circle_outline : Icons.cloud_upload_outlined,
              label: isUploaded ? 'Holiday HW Uploaded' : 'Upload Holiday HW PDF*',
              onTap: () {
                context.read<AddHolidayHwBloc>().add(
                  const UpdateHolidayHwPdfUrlEvent('https://www.aeee.in/wp-content/uploads/2020/08/Sample-pdf.pdf'),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Holiday HW PDF Attached')),
                );
              },
            ),
            if (isUploaded)
              Padding(
                padding: EdgeInsets.only(top: context.scaleHeight(8)),
                child: Text(
                  'Attachment: holiday_hw_document.pdf',
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
            child: BlocSelector<AddHolidayHwBloc, AddHolidayHwState, bool>(
              selector: (state) => state.isSubmitting,
              builder: (context, isLoading) {
                return AppPrimaryButton(
                  text: 'SAVE WORK',
                  isLoading: isLoading,
                  onPressed: () => context.read<AddHolidayHwBloc>().add(SubmitHolidayHwEvent()),
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
