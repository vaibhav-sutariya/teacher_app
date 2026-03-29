import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../core/widgets/app_app_bar.dart';
import '../../../../core/widgets/app_date_picker.dart';
import '../../../../core/widgets/app_dropdown_field.dart';
import '../../../../core/widgets/app_primary_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';
import 'bloc/add_leave_bloc.dart';
import 'models/add_leave_models.dart';

@RoutePage()
class AddLeavePage extends StatelessWidget {
  const AddLeavePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddLeaveBloc(),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: context.colors.surface100,
          appBar: AppAppBar(
            title: 'Add Leave',
            backgroundColor: context.colors.primary,
          ),
          body: BlocListener<AddLeaveBloc, AddLeaveState>(
            listener: (context, state) {
              if (state.isSuccess) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Leave applied successfully')),
                );
              } else if (state.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage!)),
                );
              }
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.all(context.scale(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Leave Type Dropdown
                  BlocSelector<AddLeaveBloc, AddLeaveState, String?>(
                    selector: (state) => state.leaveType,
                    builder: (context, selectedType) {
                      return AppDropdownField<LeaveTypeModel>(
                        label: 'Leave type',
                        value: LeaveTypeModel.getMockTypes().firstWhere(
                          (e) => e.name == selectedType,
                          orElse: () => LeaveTypeModel.getMockTypes().first,
                        ),
                        items: LeaveTypeModel.getMockTypes(),
                        itemLabel: (type) => type.name,
                        hint: 'select',
                        onChanged: (value) {
                          if (value != null) {
                            context.read<AddLeaveBloc>().add(
                                  LeaveTypeChanged(value.name),
                                );
                          }
                        },
                        validator: (value) =>
                            value == null ? 'Please select a leave type' : null,
                      );
                    },
                  ),
                  SizedBox(height: context.scaleHeight(20)),

                  // From Date
                  BlocSelector<AddLeaveBloc, AddLeaveState, DateTime?>(
                    selector: (state) => state.fromDate,
                    builder: (context, fromDate) {
                      return AppDatePickerField(
                        label: 'From',
                        selectedDate: fromDate,
                        onDateSelected: (date) {
                          final toDate = context.read<AddLeaveBloc>().state.toDate;
                          context.read<AddLeaveBloc>().add(
                                SaveDateRange(fromDate: date, toDate: toDate),
                              );
                        },
                        validator: (value) =>
                            value == null ? 'Please select a start date' : null,
                      );
                    },
                  ),
                  SizedBox(height: context.scaleHeight(20)),

                  // To Date
                  BlocSelector<AddLeaveBloc, AddLeaveState, DateTime?>(
                    selector: (state) => state.toDate,
                    builder: (context, toDate) {
                      return AppDatePickerField(
                        label: 'To',
                        selectedDate: toDate,
                        onDateSelected: (date) {
                          final fromDate =
                              context.read<AddLeaveBloc>().state.fromDate;
                          context.read<AddLeaveBloc>().add(
                                SaveDateRange(fromDate: fromDate, toDate: date),
                              );
                        },
                        validator: (value) =>
                            value == null ? 'Please select an end date' : null,
                      );
                    },
                  ),
                  SizedBox(height: context.scaleHeight(20)),

                  // Reason
                  Text(
                    'Reason',
                    style: TextStyle(
                      fontSize: context.scaleFont(14),
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(8)),
                  AppTextField(
                    hintText: 'Write your comment',
                    maxLines: 5,
                    minLines: 4,
                    onChanged: (value) {
                      context.read<AddLeaveBloc>().add(ReasonChanged(value));
                    },
                  ),
                  SizedBox(height: context.scaleHeight(24)),

                  // Choose file
                  Text(
                    'Choose file',
                    style: TextStyle(
                      fontSize: context.scaleFont(13),
                      color: context.colors.textTertiary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(12)),
                  const _FileToggle(),

                  SizedBox(height: context.scaleHeight(40)),

                  // Apply Button
                  BlocBuilder<AddLeaveBloc, AddLeaveState>(
                    builder: (context, state) {
                      return AppPrimaryButton(
                        text: 'Apply',
                        isLoading: state.isLoading,
                        onPressed: () {
                          context.read<AddLeaveBloc>().add(const SubmitLeave());
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _FileToggle extends StatelessWidget {
  const _FileToggle();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddLeaveBloc, AddLeaveState, bool>(
      selector: (state) => state.isImageSelected,
      builder: (context, isImageSelected) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(context.scale(12)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => context
                        .read<AddLeaveBloc>()
                        .add(const FileTypeChanged(true)),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: context.scaleHeight(14)),
                      alignment: Alignment.center,
                      child: Text(
                        'Image',
                        style: TextStyle(
                          fontSize: context.scaleFont(14),
                          fontWeight: isImageSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isImageSelected
                              ? context.colors.primary
                              : context.colors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ),
                VerticalDivider(
                  width: 1,
                  color: context.colors.divider,
                  indent: 10,
                  endIndent: 10,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => context
                        .read<AddLeaveBloc>()
                        .add(const FileTypeChanged(false)),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: context.scaleHeight(14)),
                      alignment: Alignment.center,
                      child: Text(
                        'Document',
                        style: TextStyle(
                          fontSize: context.scaleFont(14),
                          fontWeight: !isImageSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: !isImageSelected
                              ? context.colors.primary
                              : context.colors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
