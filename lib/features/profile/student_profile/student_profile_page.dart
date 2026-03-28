import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/widgets/app_loader.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import 'bloc/student_profile_bloc.dart';
import 'bloc/student_profile_event.dart';
import 'bloc/student_profile_state.dart';
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
              return const Center(child: AppLoader());
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
                                title: 'About Me',
                                children: [
                                  DetailRow(
                                    icon: Icons.school_outlined,
                                    label: 'Class',
                                    value: profile.className,
                                  ),
                                  DetailRow(
                                    icon: Icons.assignment_ind_outlined,
                                    label: 'GR No.',
                                    value: profile.grNo,
                                  ),
                                  DetailRow(
                                    icon: Icons.check_circle_outline,
                                    label: 'Roll No.',
                                    value: profile.rollNo,
                                  ),
                                  DetailRow(
                                    icon: Icons.phone_android_outlined,
                                    label: 'Phone No.',
                                    value: profile.phoneNumber,
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
                                    label: 'Father Name',
                                    value: profile.familyInfo.fatherName,
                                  ),
                                  DetailRow(
                                    label: 'Mother Name',
                                    value: profile.familyInfo.motherName,
                                    showDivider: false,
                                  ),
                                ],
                              ),
                              DetailSectionCard(
                                title: 'Communication',
                                children: [
                                  DetailRow(
                                    label: 'Address',
                                    value: profile.communicationInfo.address,
                                    showDivider: false,
                                  ),
                                ],
                              ),
                              DetailSectionCard(
                                title: 'Academic Info',
                                children: [
                                  DetailRow(
                                    label: 'Date of Admission',
                                    value: profile.academicInfo.dateOfAdmission,
                                  ),
                                  DetailRow(
                                    label: 'Previous School',
                                    value: profile.academicInfo.previousSchool,
                                  ),
                                  DetailRow(
                                    label: 'RTE Student',
                                    value: profile.academicInfo.rteStudent,
                                  ),
                                  DetailRow(
                                    label: 'House',
                                    value: profile.academicInfo.house,
                                    showDivider: false,
                                  ),
                                ],
                              ),
                              DetailSectionCard(
                                title: 'Document',
                                children: profile.documents.map((doc) {
                                  return DetailRow(
                                    label: doc.name,
                                    value: doc.number,
                                    showDivider: doc != profile.documents.last,
                                  );
                                }).toList(),
                              ),
                              DetailSectionCard(
                                title: 'Enquiry Info',
                                children: [
                                  DetailRow(
                                    label: 'Date of enquiry',
                                    value: profile.enquiryInfo.dateOfEnquiry,
                                  ),
                                  DetailRow(
                                    label: 'Date of registration',
                                    value:
                                        profile.enquiryInfo.dateOfRegistration,
                                  ),
                                  DetailRow(
                                    label: 'Ref person name',
                                    value: profile.enquiryInfo.refPersonName,
                                  ),
                                  DetailRow(
                                    label: 'Remarks',
                                    value: profile.enquiryInfo.remarks,
                                    showDivider: false,
                                  ),
                                ],
                              ),
                              SizedBox(height: context.scaleHeight(16)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  _KnowMoreBanner(),
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

class _KnowMoreBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey.shade800,
      padding: EdgeInsets.symmetric(vertical: context.scaleHeight(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Know More',
            style: TextStyle(
              color: Colors.white,
              fontSize: context.scaleFont(14),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: context.scale(4)),
          const Icon(Icons.chevron_right, color: Colors.white, size: 20),
        ],
      ),
    );
  }
}
