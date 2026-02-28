import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../core/utils/app_image_picker.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../../../../core/widgets/app_app_bar.dart';
import '../../../../core/widgets/app_dropdown_field.dart';
import '../../../../core/widgets/app_primary_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import 'bloc/add_concern_bloc.dart';
import 'bloc/add_concern_event.dart';
import 'bloc/add_concern_state.dart';
import 'models/add_concern_request_model.dart';
import 'widgets/attachment_upload_area.dart';

@RoutePage()
class AddConcernPage extends StatelessWidget {
  const AddConcernPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddConcernBloc(),
      child: const AddConcernView(),
    );
  }
}

class AddConcernView extends StatefulWidget {
  const AddConcernView({super.key});

  @override
  State<AddConcernView> createState() => _AddConcernViewState();
}

class _AddConcernViewState extends State<AddConcernView> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _selectedCategory;
  // _attachmentPath removed in favor of BLoC state

  final List<String> _categories = [
    'ADMINISTRATION',
    'ACADEMIC I AND II',
    'TRANSPORT',
    'ACCOUNTS AND FEES',
    'ADMISSION',
    'CO CIRCULAR ACTIVITY',
    'INFRASTRUCTURE',
    'FEEDBACK OR SUGGESTIONS IF ANY',
    'ACADEMIC III AND IV',
    'ACADEMIC V AND VI',
    'ACADEMIC VII AND VIII',
    'ACADEMIC IX AND X',
    'ACADEMIC XI AND XII',
    'PRE PRIMARY LITTLE SEEDS',
    'PRE PRIMARY LITTLE CHAMPS',
    'PRE PRIMARY JR KG',
  ];

  @override
  void dispose() {
    _subjectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    final imagePicker = AppImagePicker();
    await imagePicker.showImagePickerOption(
      context,
      onImageSelected: (path) {
        // No setState here, dispatch event to BLoC
        context.read<AddConcernBloc>().add(FileSelected(path));
      },
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      // Access current state to get attachment path
      final currentAttachment = context
          .read<AddConcernBloc>()
          .state
          .attachmentPath;

      final request = AddConcernRequestModel(
        category: _selectedCategory!,
        subject: _subjectController.text.trim(),
        description: _descriptionController.text.trim(),
        attachmentPath: currentAttachment,
      );
      context.read<AddConcernBloc>().add(SubmitConcern(request));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7), // Light grey background
      appBar: const AppAppBar(title: 'Add Concern'),
      body: BlocListener<AddConcernBloc, AddConcernState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == AddConcernStatus.success) {
            // Navigate back and indicate success
            context.router.pop(true);
          } else if (state.status == AddConcernStatus.failure) {
            showFlushbar(
              context: context,
              message: state.message ?? 'An error occurred',
              isError: true,
            );
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(context.scale(16)),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel(context, 'CATEGORY'),
                AppDropdownField<String>(
                  label: '',
                  value: _selectedCategory,
                  items: _categories,
                  itemLabel: (item) => item,
                  hint: 'Select a category...',
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                ),
                SizedBox(height: context.scaleHeight(24)),

                _buildLabel(context, 'SUBJECT'),
                AppTextField(
                  controller: _subjectController,
                  hintText: 'Enter subject',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a subject';
                    }
                    if (value.trim().length < 3) {
                      return 'Subject must be at least 3 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: context.scaleHeight(24)),

                _buildLabel(context, 'DETAILED DESCRIPTION'),
                AppTextField(
                  controller: _descriptionController,
                  hintText:
                      'Provide detailed information about your concern...',
                  maxLines: 5,
                  minLines: 5,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a description';
                    }
                    if (value.trim().length < 10) {
                      return 'Description must be at least 10 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: context.scaleHeight(24)),

                _buildLabel(context, 'ATTACHMENTS'),
                // Only rebuild this widget when attachmentPath changes
                BlocSelector<AddConcernBloc, AddConcernState, String?>(
                  selector: (state) => state.attachmentPath,
                  builder: (context, attachmentPath) {
                    return AttachmentUploadArea(
                      onTap: _pickFile,
                      selectedFile: attachmentPath,
                    );
                  },
                ),

                SizedBox(height: context.scaleHeight(32)),

                // Only rebuild button when loading status changes
                BlocSelector<AddConcernBloc, AddConcernState, bool>(
                  selector: (state) => state.status == AddConcernStatus.loading,
                  builder: (context, isLoading) {
                    return AppPrimaryButton(
                      onPressed: _handleSubmit,
                      isLoading: isLoading,
                      height: 50,
                      borderRadius: 12,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Submit Concern',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: context.scale(8)),
                          Icon(
                            Icons.send_rounded,
                            size: context.scale(18),
                            color: Colors.white,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: context.scaleHeight(24)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(BuildContext context, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.scaleHeight(8)),
      child: Text(
        text,
        style: TextStyle(
          fontSize: context.scaleFont(12), // Small caps style
          fontWeight: FontWeight.bold,
          color: const Color(0xFF3F51B5), // Indigo color
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}
