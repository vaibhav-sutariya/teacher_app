import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';
import 'package:teachers_app/core/widgets/app_date_picker.dart';
import 'package:teachers_app/core/widgets/app_primary_button.dart';
import 'package:teachers_app/core/widgets/app_text_field.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import 'bloc/add_ptm_bloc.dart';
import 'bloc/add_ptm_event.dart';
import 'bloc/add_ptm_state.dart';

@RoutePage()
class AddPtmPage extends StatelessWidget {
  const AddPtmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddPtmBloc(),
      child: const _AddPtmContent(),
    );
  }
}

class _AddPtmContent extends StatelessWidget {
  const _AddPtmContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface100,
      appBar: const AppAppBar(title: 'Add PTM'),
      body: BlocListener<AddPtmBloc, AddPtmState>(
        listener: (context, state) {
          if (state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('PTM scheduled successfully!')),
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
              const _SectionLabel('PTM Title', isRequired: true),
              SizedBox(height: context.scaleHeight(12)),
              const _TitleField(),
              SizedBox(height: context.scaleHeight(24)),
              const _SectionLabel('PTM Date', isRequired: true),
              SizedBox(height: context.scaleHeight(12)),
              const _DatePickerField(),
              SizedBox(height: context.scaleHeight(24)),
              const _SectionLabel('PTM Time', isRequired: true),
              SizedBox(height: context.scaleHeight(12)),
              const _TimeField(),
              SizedBox(height: context.scaleHeight(24)),
              const _SectionLabel('Location', isRequired: true),
              SizedBox(height: context.scaleHeight(12)),
              const _LocationField(),
              SizedBox(height: context.scaleHeight(24)),
              const _SectionLabel('Description', isRequired: true),
              SizedBox(height: context.scaleHeight(12)),
              const _DescriptionField(),
              SizedBox(height: context.scaleHeight(40)),
              const _SubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TitleField extends StatelessWidget {
  const _TitleField();

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      hintText: 'Enter PTM title',
      onChanged: (val) {
        context.read<AddPtmBloc>().add(TitleChanged(val));
      },
    );
  }
}

class _DatePickerField extends StatelessWidget {
  const _DatePickerField();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddPtmBloc, AddPtmState, DateTime?>(
      selector: (state) => state.date,
      builder: (context, date) {
        return AppDatePickerField(
          label: '',
          selectedDate: date,
          onDateSelected: (selected) {
            if (selected != null) {
              context.read<AddPtmBloc>().add(DateChanged(selected));
            }
          },
        );
      },
    );
  }
}

class _TimeField extends StatelessWidget {
  const _TimeField();

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      hintText: 'Enter time (e.g. 10:00 AM - 11:00 AM)',
      onChanged: (val) {
        context.read<AddPtmBloc>().add(TimeChanged(val));
      },
    );
  }
}

class _LocationField extends StatelessWidget {
  const _LocationField();

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      hintText: 'Enter meeting location',
      onChanged: (val) {
        context.read<AddPtmBloc>().add(LocationChanged(val));
      },
    );
  }
}

class _DescriptionField extends StatelessWidget {
  const _DescriptionField();

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      hintText: 'Enter PTM description',
      maxLines: 4,
      onChanged: (val) {
        context.read<AddPtmBloc>().add(DescriptionChanged(val));
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPtmBloc, AddPtmState>(
      buildWhen: (previous, current) =>
          previous.isLoading != current.isLoading ||
          previous.isFormValid != current.isFormValid,
      builder: (context, state) {
        return AppPrimaryButton(
          onPressed: (state.isLoading || !state.isFormValid)
              ? null
              : () {
                  context.read<AddPtmBloc>().add(const SubmitPtm());
                },
          text: state.isLoading ? 'SCHEDULING...' : 'ADD PTM',
        );
      },
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
      mainAxisSize: MainAxisSize.min,
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
