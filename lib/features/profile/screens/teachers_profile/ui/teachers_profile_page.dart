import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/widgets/app_loader.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';
import '../../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../bloc/teachers_profile_bloc.dart';
import '../bloc/teachers_profile_event.dart';
import '../bloc/teachers_profile_state.dart';
import 'widgets/detail_section_card.dart';
import 'widgets/student_profile_header.dart';

@RoutePage()
class StudentProfilePage extends StatelessWidget {
  const StudentProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentProfileBloc()..add(LoadStudentProfile()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<StudentProfileBloc, StudentProfileState>(
          builder: (context, state) {
            if (state is StudentProfileLoading) {
              return Center(
                child: CircularProgressIndicator(color: context.colors.primary),
              );
            } else if (state is StudentProfileLoaded) {
              final profile = state.profile;
              return Column(
                children: [
                  Expanded(
                    child: CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                          child: Stack(
                            children: [
                              StudentProfileHeader(profile: profile),
                              Positioned(
                                top: context.scaleHeight(40),
                                left: context.scale(16),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  onPressed: () => context.router.back(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              SizedBox(height: context.scaleHeight(16)),
                              DetailSectionCard(
                                title: 'Employee Details',
                                children: [
                                  DetailRow(
                                    icon: Icons.badge_outlined,
                                    label: 'Employee ID',
                                    value: profile.employeeId,
                                  ),
                                  DetailRow(
                                    icon: Icons.work_outline,
                                    label: 'Designation',
                                    value: profile.designation,
                                  ),
                                  DetailRow(
                                    icon: Icons.business_outlined,
                                    label: 'Department',
                                    value: profile.department,
                                  ),
                                  DetailRow(
                                    icon: Icons.calendar_today_outlined,
                                    label: 'Joining Date',
                                    value: profile.joiningDate,
                                    showDivider: false,
                                  ),
                                ],
                              ),
                              DetailSectionCard(
                                title: 'Basic Info',
                                children: [
                                  DetailRow(
                                    label: 'Birth Date',
                                    value: profile.basicInfo.dob,
                                  ),
                                  DetailRow(
                                    label: 'Gender',
                                    value: profile.basicInfo.gender,
                                  ),
                                  DetailRow(
                                    label: 'Blood Group',
                                    value: profile.basicInfo.bloodGroup,
                                  ),
                                  DetailRow(
                                    label: 'Marital Status',
                                    value: profile.basicInfo.maritalStatus,
                                    showDivider: false,
                                  ),
                                ],
                              ),
                              DetailSectionCard(
                                title: 'Contact Info',
                                children: [
                                  DetailRow(
                                    label: 'Phone Number',
                                    value: profile.phoneNumber,
                                  ),
                                  DetailRow(
                                    label: 'Email Address',
                                    value: profile.communicationInfo.email,
                                  ),
                                  DetailRow(
                                    label: 'Address',
                                    value: profile.communicationInfo.address,
                                    showDivider: false,
                                  ),
                                ],
                              ),
                              DetailSectionCard(
                                title: 'Qualifications',
                                children: [
                                  DetailRow(
                                    label: 'Highest Qualification',
                                    value: profile.qualification,
                                  ),
                                  DetailRow(
                                    label: 'Experience',
                                    value: profile.experience,
                                    showDivider: false,
                                  ),
                                ],
                              ),
                              DetailSectionCard(
                                title: 'Documents',
                                children: profile.documents.map((doc) {
                                  return DetailRow(
                                    label: doc.name,
                                    value: doc.number,
                                    showDivider: doc != profile.documents.last,
                                  );
                                }).toList(),
                              ),
                              SizedBox(height: context.scaleHeight(16)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is StudentProfileError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
