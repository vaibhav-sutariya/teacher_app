import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../core/widgets/app_app_bar.dart';
import '../../../../../core/widgets/app_date_picker.dart';
import '../../../../../core/widgets/app_dropdown_field.dart';
import '../../../../../core/widgets/app_primary_button.dart';
import '../../../../../core/widgets/app_text_field.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';
import 'bloc/add_punch_bloc.dart';

@RoutePage()
class AddManualPunchPage extends StatefulWidget {
  const AddManualPunchPage({super.key});

  @override
  State<AddManualPunchPage> createState() => _AddManualPunchPageState();
}

class _AddManualPunchPageState extends State<AddManualPunchPage> {
  DateTime selectedDate = DateTime.now();
  String? selectedType;
  final TextEditingController timeController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddPunchBloc(),
      child: BlocListener<AddPunchBloc, AddPunchState>(
        listener: (context, state) {
          if (state is AddPunchSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Manual Punch added successfully')),
            );
            context.router.back();
          } else if (state is AddPunchError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Scaffold(
          backgroundColor: context.colors.surface100,
          appBar: const AppAppBar(title: 'Add Manual Punch'),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(context.scale(16)),
            child: Column(
              children: [
                // Date Picker
                AppDatePickerField(
                  label: 'Punch Date',
                  selectedDate: selectedDate,
                  onDateSelected: (date) {
                    if (date != null) {
                      setState(() {
                        selectedDate = date;
                      });
                    }
                  },
                ),
                SizedBox(height: context.scaleHeight(16)),

                // Punch Type Dropdown
                AppDropdownField<String>(
                  label: 'Punch Type',
                  items: const ['In Punch', 'Out Punch'],
                  itemLabel: (item) => item,
                  hint: 'Select Punch Type',
                  value: selectedType,
                  onChanged: (value) {
                    setState(() {
                      selectedType = value;
                    });
                  },
                ),
                SizedBox(height: context.scaleHeight(16)),

                // Punch Time
                AppTextField(
                  labelText: 'Punch Time',
                  hintText: 'e.g. 09:30 AM',
                  controller: timeController,
                ),
                SizedBox(height: context.scaleHeight(16)),

                // Reason
                AppTextField(
                  labelText: 'Reason',
                  hintText: 'Enter reason for manual punch',
                  controller: reasonController,
                  maxLines: 4,
                ),
                SizedBox(height: context.scaleHeight(32)),

                // Submit Button
                BlocBuilder<AddPunchBloc, AddPunchState>(
                  builder: (context, state) {
                    return AppPrimaryButton(
                      text: 'SUBMIT',
                      isLoading: state is AddPunchSubmitting,
                      onPressed: () {
                        if (selectedType == null ||
                            timeController.text.isEmpty ||
                            reasonController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill all fields'),
                            ),
                          );
                          return;
                        }

                        context.read<AddPunchBloc>().add(
                          SubmitPunch(
                            date: selectedDate,
                            type: selectedType!,
                            time: timeController.text,
                            reason: reasonController.text,
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
