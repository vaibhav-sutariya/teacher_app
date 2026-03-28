import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../core/routes/app_router.gr.dart';
import '../../../../../core/widgets/app_app_bar.dart';
import '../../../../../core/widgets/app_dropdown_field.dart';
import '../../../../../core/widgets/app_primary_button.dart';
import '../../../../../core/widgets/app_text_field.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import '../models/gate_pass_model.dart';
import 'bloc/add_gate_pass_bloc.dart';
import 'bloc/add_gate_pass_event.dart';
import 'bloc/add_gate_pass_state.dart';

@RoutePage()
class AddGatePassPage extends StatelessWidget {
  const AddGatePassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddGatePassBloc(),
      child: const _AddGatePassContent(),
    );
  }
}

class _AddGatePassContent extends StatelessWidget {
  const _AddGatePassContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppAppBar(
        title: 'Assign Gate Pass',
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
                          AddGatePassBloc,
                          AddGatePassState,
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
                                  context.read<AddGatePassBloc>().add(
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
                          AddGatePassBloc,
                          AddGatePassState,
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
                                  context.read<AddGatePassBloc>().add(
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

              // 2. Date & Time Pickers
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SectionLabel('Date *'),
                        SizedBox(height: context.scaleHeight(6)),
                        BlocSelector<
                          AddGatePassBloc,
                          AddGatePassState,
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
                                );
                                if (picked != null && context.mounted) {
                                  context.read<AddGatePassBloc>().add(
                                    SelectDateEvent(picked),
                                  );
                                }
                              },
                              borderRadius: BorderRadius.circular(
                                context.scale(12),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: context.scale(12),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      size: context.scale(18),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: context.scale(16)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SectionLabel('Out Time *'),
                        SizedBox(height: context.scaleHeight(6)),
                        BlocSelector<
                          AddGatePassBloc,
                          AddGatePassState,
                          String?
                        >(
                          selector: (state) => state.time,
                          builder: (context, time) {
                            return InkWell(
                              onTap: () async {
                                final picked = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (picked != null && context.mounted) {
                                  final formatted = picked.format(context);
                                  context.read<AddGatePassBloc>().add(
                                    SelectTimeEvent(formatted),
                                  );
                                }
                              },
                              borderRadius: BorderRadius.circular(
                                context.scale(12),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: context.scale(12),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      time ?? 'Select Time',
                                      style: TextStyle(
                                        fontSize: context.scaleFont(14),
                                        color: time == null
                                            ? context.colors.textTertiary
                                            : context.colors.textPrimary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Icon(
                                      Icons.access_time_outlined,
                                      color: context.colors.primary,
                                      size: context.scale(18),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.scaleHeight(20)),

              // 3. Pickup By Dropdown
              BlocSelector<AddGatePassBloc, AddGatePassState, GatePassType>(
                selector: (state) => state.pickupType,
                builder: (context, pickupType) {
                  return AppDropdownField<GatePassType>(
                    isOutlined: true,
                    label: 'Pickup By *',
                    hint: 'Select Pickup Type',
                    value: pickupType,
                    items: const [GatePassType.student, GatePassType.parent],
                    itemLabel: (GatePassType v) => v == GatePassType.student
                        ? 'Student Alone'
                        : 'With Parent',
                    onChanged: (val) {
                      if (val != null) {
                        context.read<AddGatePassBloc>().add(
                          SelectPickupTypeEvent(val),
                        );
                      }
                    },
                  );
                },
              ),
              SizedBox(height: context.scaleHeight(20)),

              // 4. Reason Field
              _SectionLabel('Reason for Leave *'),
              SizedBox(height: context.scaleHeight(6)),
              AppTextField(
                hintText: 'Enter specific reason here',
                maxLines: 4,
                minLines: 3,
                onChanged: (val) {
                  context.read<AddGatePassBloc>().add(UpdateReasonEvent(val));
                },
              ),
              SizedBox(height: context.scaleHeight(40)),

              // Error Display
              BlocSelector<AddGatePassBloc, AddGatePassState, String?>(
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

              // 5. Next Button
              AppPrimaryButton(
                onPressed: () {
                  final blocState = context.read<AddGatePassBloc>().state;
                  if (blocState.selectedClass == null ||
                      blocState.section == null ||
                      blocState.time == null ||
                      blocState.reason.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill all required fields'),
                      ),
                    );
                    return;
                  }
                  context.router.push(
                    GatePassStudentSelectionRoute(
                      className: blocState.selectedClass!,
                      section: blocState.section!,
                      addGatePassBloc: context.read<AddGatePassBloc>(),
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
