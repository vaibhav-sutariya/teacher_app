import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:teachers_app/cubit/theme_cubit.dart';

import 'package:teachers_app/features/my_class/gate_pass/screens/add_gate_pass/bloc/add_gate_pass_bloc.dart';

import '../../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../../core/widgets/app_app_bar.dart';
import '../../../../../../core/widgets/app_loader.dart';
import '../../../../../../core/widgets/app_primary_button.dart';
import '../bloc/add_gate_pass_event.dart';
import '../bloc/add_gate_pass_state.dart';

@RoutePage()
class GatePassStudentSelectionPage extends StatelessWidget {
  final String className;
  final String section;
  final AddGatePassBloc addGatePassBloc;

  const GatePassStudentSelectionPage({
    super.key,
    required this.className,
    required this.section,
    required this.addGatePassBloc,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: addGatePassBloc..add(LoadStudentsEvent()),
      child: _GatePassStudentSelectionContent(
        className: className,
        section: section,
      ),
    );
  }
}

class _GatePassStudentSelectionContent extends StatelessWidget {
  final String className;
  final String section;

  const _GatePassStudentSelectionContent({
    required this.className,
    required this.section,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddGatePassBloc, AddGatePassState>(
      listenWhen: (previous, current) =>
          previous.submitSuccess != current.submitSuccess,
      listener: (context, state) {
        if (state.submitSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gate pass assigned successfully!')),
          );
          context.router.maybePopTop();
          context.router.maybePopTop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppAppBar(
          title: 'Select Student',
          backgroundColor: Colors.white,
          foregroundColor: context.colors.textPrimary,
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: context.scale(20),
                vertical: context.scaleHeight(16),
              ),
              color: context.colors.surface100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CLASS & SECTION',
                    style: TextStyle(
                      fontSize: context.scaleFont(11),
                      fontWeight: FontWeight.bold,
                      color: context.colors.primary,
                      letterSpacing: 1.0,
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(4)),
                  Text(
                    '$className - Section $section',
                    style: TextStyle(
                      fontSize: context.scaleFont(15),
                      fontWeight: FontWeight.bold,
                      color: context.colors.textPrimary,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.scale(20)),
                child: Column(
                  children: [
                    SizedBox(height: context.scaleHeight(16)),
                    TextFormField(
                      onChanged: (val) {
                        context.read<AddGatePassBloc>().add(
                          SearchStudentsEvent(val),
                        );
                      },
                      style: TextStyle(
                        fontSize: context.scaleFont(14),
                        color: context.colors.textPrimary,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search students by name or roll no',
                        hintStyle: TextStyle(
                          fontSize: context.scaleFont(14),
                          color: context.colors.textTertiary,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: context.colors.primary.withValues(alpha: 0.7),
                        ),
                        filled: true,
                        fillColor: context.colors.surface100,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: context.scaleHeight(14),
                          horizontal: context.scale(16),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            context.scale(12),
                          ),
                          borderSide: BorderSide(
                            color: context.colors.border,
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            context.scale(12),
                          ),
                          borderSide: BorderSide(
                            color: context.colors.border,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            context.scale(12),
                          ),
                          borderSide: BorderSide(
                            color: context.colors.primary,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: context.scaleHeight(16)),
                    Expanded(
                      child: BlocBuilder<AddGatePassBloc, AddGatePassState>(
                        builder: (context, state) {
                          if (state.isLoadingStudents) {
                            return Center(
                              child: AppLoader(color: context.colors.primary),
                            );
                          }
                          if (state.filteredStudents.isEmpty) {
                            return const Center(
                              child: Text('No students found.'),
                            );
                          }
                          return ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.filteredStudents.length,
                            separatorBuilder: (context, index) =>
                                SizedBox(height: context.scaleHeight(16)),
                            itemBuilder: (context, index) {
                              final student = state.filteredStudents[index];
                              final isSelected =
                                  state.selectedStudentId == student.id;

                              return GestureDetector(
                                onTap: () {
                                  context.read<AddGatePassBloc>().add(
                                    SelectStudentEvent(student.id),
                                  );
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              student.name,
                                              style: TextStyle(
                                                fontSize: context.scaleFont(15),
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    context.colors.textPrimary,
                                              ),
                                            ),
                                            SizedBox(
                                              height: context.scaleHeight(4),
                                            ),
                                            Text(
                                              'Roll No: ${student.rollNo}',
                                              style: TextStyle(
                                                fontSize: context.scaleFont(13),
                                                color: context
                                                    .colors
                                                    .textSecondary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: context.scale(24),
                                        height: context.scale(24),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: isSelected
                                              ? context.colors.primary
                                              : Colors.white,
                                          border: Border.all(
                                            color: isSelected
                                                ? context.colors.primary
                                                : context.colors.border,
                                            width: 1.5,
                                          ),
                                        ),
                                        child: isSelected
                                            ? Icon(
                                                Icons.circle,
                                                color: Colors.white,
                                                size: context.scale(10),
                                              )
                                            : null,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.scale(20),
                vertical: context.scaleHeight(16),
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0A000000),
                    offset: Offset(0, -4),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: BlocSelector<AddGatePassBloc, AddGatePassState, bool>(
                  selector: (state) => state.isSubmitting,
                  builder: (context, isSubmitting) {
                    return AppPrimaryButton(
                      onPressed: () {
                        final bloc = context.read<AddGatePassBloc>();
                        if (bloc.state.selectedStudentId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select a student'),
                            ),
                          );
                          return;
                        }
                        bloc.add(SubmitGatePassEvent());
                      },
                      text: 'ASSIGN GATE PASS',
                      isLoading: isSubmitting,
                      color: context.colors.primary,
                      borderRadius: context.scale(12),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
