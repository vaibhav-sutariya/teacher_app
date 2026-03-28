import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../core/widgets/app_app_bar.dart';
import '../../../../core/widgets/app_dashed_upload_button.dart';
import '../../../../core/widgets/app_dropdown_field.dart';
import '../../../../core/widgets/app_primary_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../cubit/theme_cubit.dart';
import '../bloc/time_table_bloc.dart';
import '../models/time_table_model.dart';

@RoutePage()
class AddTimeTablePage extends StatefulWidget implements AutoRouteWrapper {
  const AddTimeTablePage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => TimeTableBloc(repository: sl.get()),
      child: this,
    );
  }

  @override
  State<AddTimeTablePage> createState() => _AddTimeTablePageState();
}

class _AddTimeTablePageState extends State<AddTimeTablePage> {
  final _formKey = GlobalKey<FormState>();
  String? selectedClass;
  String? selectedType;
  final _teacherController = TextEditingController();
  final _pdfUrlController = TextEditingController();

  final List<String> classes = ['Sr.KG', 'Jr.KG', '1st', '2nd', '3rd', '4th', '5th'];
  final List<String> types = ['JAL', 'VAYU', 'AAKASH', 'PRITHVI', 'TEJ'];

  @override
  void dispose() {
    _teacherController.dispose();
    _pdfUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface,
      appBar: const AppAppBar(title: 'Add Timetable', showBackButton: true),
      body: BlocListener<TimeTableBloc, TimeTableState>(
        listener: (context, state) {
          if (state is TimeTableAdded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Timetable added successfully')),
            );
            context.router.back();
          } else if (state is TimeTableError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(context.scale(16)),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppDropdownField<String>(
                  label: 'Select Class',
                  value: selectedClass,
                  items: classes,
                  itemLabel: (item) => item,
                  onChanged: (val) => setState(() => selectedClass = val),
                  validator: (val) => val == null ? 'Please select a class' : null,
                ),
                SizedBox(height: context.scaleHeight(16)),
                AppDropdownField<String>(
                  label: 'Select Type',
                  value: selectedType,
                  items: types,
                  itemLabel: (item) => item,
                  onChanged: (val) => setState(() => selectedType = val),
                  validator: (val) => val == null ? 'Please select a type' : null,
                ),
                SizedBox(height: context.scaleHeight(16)),
                AppTextField(
                  labelText: 'Class Teacher Name',
                  controller: _teacherController,
                  validator: (val) =>
                      val == null || val.isEmpty ? 'Please enter teacher name' : null,
                ),
                SizedBox(height: context.scaleHeight(16)),
                AppTextField(
                  labelText: 'PDF URL',
                  controller: _pdfUrlController,
                  validator: (val) =>
                      val == null || val.isEmpty ? 'Please enter PDF URL' : null,
                  hintText: 'https://example.com/timetable.pdf',
                ),
                SizedBox(height: context.scaleHeight(24)),
                // Simulated Upload Button
                AppDashedUploadButton(
                  icon: Icons.cloud_upload_outlined,
                  label: 'Upload PDF Attachment',
                  onTap: () {
                    // Simulated file picking
                    _pdfUrlController.text =
                        'https://www.aeee.in/wp-content/uploads/2020/08/Sample-pdf.pdf';
                  },
                ),
                SizedBox(height: context.scaleHeight(40)),
                BlocBuilder<TimeTableBloc, TimeTableState>(
                  builder: (context, state) {
                    return AppPrimaryButton(
                      text: 'Save Timetable',
                      isLoading: state is TimeTableAdding,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final model = TimeTableModel(
                            id: DateTime.now().millisecondsSinceEpoch.toString(),
                            className: selectedClass!,
                            divisionName: selectedType!, // Using type as division for now
                            classTeacherName: _teacherController.text,
                            pdfUrl: _pdfUrlController.text,
                            type: selectedType,
                          );
                          context.read<TimeTableBloc>().add(AddTimeTable(model));
                        }
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
