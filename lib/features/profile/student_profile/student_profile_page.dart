import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';

import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../cubit/theme_cubit.dart';
import 'bloc/student_profile_bloc.dart';
import 'bloc/student_profile_event.dart';
import 'bloc/student_profile_state.dart';
import 'widgets/family_info_widget.dart';
import 'widgets/profile_info_card.dart';

@RoutePage()
class StudentProfilePage extends StatelessWidget {
  const StudentProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentProfileBloc()..add(LoadStudentProfile()),
      child: Scaffold(
        appBar: AppAppBar(title: 'Student profile'),
        body: BlocBuilder<StudentProfileBloc, StudentProfileState>(
          builder: (context, state) {
            if (state is StudentProfileLoading) {
              return const Center(child: AppLoader());
            } else if (state is StudentProfileLoaded) {
              final profile = state.profile;
              return SingleChildScrollView(
                padding: EdgeInsets.all(context.scale(20)),
                child: Column(
                  children: [
                    // Profile Header
                    Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(context.scale(4)),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: context.colors.primary,
                              width: 2,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: context.scale(50),
                            backgroundImage: const NetworkImage(
                              'https://avatar.iran.liara.run/public',
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(context.scale(6)),
                            decoration: BoxDecoration(
                              color: context.colors.primary,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: context.colors.surface,
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              Icons.edit_rounded,
                              color: context.colors.surface,
                              size: context.scale(14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.scaleHeight(16)),
                    Text(
                      profile.name,
                      style: context.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colors.surface900,
                        fontSize: context.scaleFont(24),
                      ),
                    ),
                    SizedBox(height: context.scaleHeight(4)),
                    Text(
                      'Student ID: ${profile.studentId}',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: context.scaleFont(14),
                      ),
                    ),
                    SizedBox(height: context.scaleHeight(12)),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.scale(16),
                        vertical: context.scaleHeight(6),
                      ),
                      decoration: BoxDecoration(
                        color: context.colors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.school_rounded,
                            size: context.scale(16),
                            color: context.colors.primary,
                          ),
                          SizedBox(width: context.scale(8)),
                          Text(
                            profile.className,
                            style: context.textTheme.labelMedium?.copyWith(
                              color: context.colors.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: context.scaleFont(12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: context.scaleHeight(32)),

                    // About Me
                    ProfileInfoCard(
                      title: 'About Me',
                      icon: Icons.person_rounded,
                      child: Text(
                        profile.aboutMe,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colors.surface600,
                          fontStyle: FontStyle.italic,
                          height: 1.5,
                          fontSize: context.scaleFont(14),
                        ),
                      ),
                    ),

                    // Family Info
                    FamilyInfoWidget(familyInfo: profile.familyInfo),

                    // Basic Info
                    ProfileInfoCard(
                      title: 'Basic Info',
                      icon: Icons.info_rounded,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildInfoColumn(
                            context,
                            'BIRTH DATE',
                            profile.basicInfo.dob,
                          ),
                          _buildInfoColumn(
                            context,
                            'GENDER',
                            profile.basicInfo.gender,
                          ),
                          _buildInfoColumn(
                            context,
                            'BLOOD GROUP',
                            profile.basicInfo.bloodGroup,
                            isHighLighted: true,
                          ),
                        ],
                      ),
                    ),

                    // Communication
                    ProfileInfoCard(
                      title: 'Communication',
                      icon: Icons.contact_mail_rounded,
                      child: Column(
                        children: [
                          _buildCommunicationRow(
                            context,
                            Icons.location_on_rounded,
                            'PERMANENT ADDRESS',
                            '${profile.communicationInfo.address}\nPincode: ${profile.communicationInfo.pincode}',
                          ),
                          SizedBox(height: context.scaleHeight(16)),
                          _buildCommunicationRow(
                            context,
                            Icons.phone_rounded,
                            'MOBILE',
                            profile.communicationInfo.mobile,
                            trailing: IconButton(
                              onPressed: () {},
                              icon: CircleAvatar(
                                radius: 16,
                                backgroundColor: context.colors.primary
                                    .withValues(alpha: 0.1),
                                child: Icon(
                                  Icons.phone_rounded,
                                  size: 16,
                                  color: context.colors.primary,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: context.scaleHeight(16)),
                          _buildCommunicationRow(
                            context,
                            Icons.email_rounded,
                            'EMAIL ADDRESS',
                            profile.communicationInfo.email,
                            trailing: IconButton(
                              onPressed: () {},
                              icon: CircleAvatar(
                                radius: 16,
                                backgroundColor: context.colors.primary
                                    .withValues(alpha: 0.1),
                                child: Icon(
                                  Icons.send_rounded,
                                  size: 16,
                                  color: context.colors.primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Academic
                    ProfileInfoCard(
                      title: 'Academic',
                      icon: Icons.menu_book_rounded,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildAcademicItem(
                                context,
                                'PEN NUMBER',
                                profile.academicInfo.penNumber,
                              ),
                              _buildAcademicItem(
                                context,
                                'ADMISSION ID',
                                profile.academicInfo.admissionId,
                              ),
                            ],
                          ),
                          SizedBox(height: context.scaleHeight(16)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildAcademicItem(
                                context,
                                'DATE OF ADMISSION',
                                profile.academicInfo.dateOfAdmission,
                              ),
                              _buildAcademicItem(
                                context,
                                'RTE STUDENT',
                                profile.academicInfo.rteStudent,
                              ),
                            ],
                          ),
                          SizedBox(height: context.scaleHeight(16)),
                          _buildAcademicItem(
                            context,
                            'PREVIOUS SCHOOL',
                            profile.academicInfo.previousSchool,
                            isFullWidth: true,
                          ),
                          SizedBox(height: context.scaleHeight(16)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildAcademicItem(
                                context,
                                'HOUSE',
                                profile.academicInfo.house,
                                hasColorDot: true,
                              ),
                              _buildAcademicItem(
                                context,
                                'CLASS TEACHER',
                                profile.academicInfo.classTeacher,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Documents
                    ProfileInfoCard(
                      title: 'Documents',
                      icon: Icons.description_rounded,
                      child: Column(
                        children: profile.documents.map((doc) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: context.scaleHeight(12),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(context.scale(10)),
                                  decoration: BoxDecoration(
                                    color: context.colors.surface100,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Icons.assignment_ind_rounded,
                                    color: context.colors.surface400,
                                  ),
                                ),
                                SizedBox(width: context.scale(12)),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        doc.name,
                                        style: context.textTheme.labelSmall
                                            ?.copyWith(
                                              color: context
                                                  .colors
                                                  .primary //
                                                  .withValues(alpha: 0.6),
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      Text(
                                        doc.number,
                                        style: context.textTheme.bodyMedium
                                            ?.copyWith(
                                              color: context.colors.surface900,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right_rounded,
                                  color: context.colors.surface400,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
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

  Widget _buildInfoColumn(
    BuildContext context,
    String label,
    String value, {
    bool isHighLighted = false,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: context.textTheme.labelSmall?.copyWith(
            color: context.colors.surface400,
            fontWeight: FontWeight.w600,
            fontSize: context.scaleFont(11),
          ),
        ),
        SizedBox(height: context.scaleHeight(4)),
        Text(
          value,
          style: context.textTheme.titleMedium?.copyWith(
            color: isHighLighted
                ? context.colors.primary
                : context.colors.surface900,
            fontWeight: FontWeight.bold,
            fontSize: context.scaleFont(16),
          ),
        ),
      ],
    );
  }

  Widget _buildCommunicationRow(
    BuildContext context,
    IconData icon,
    String label,
    String value, {
    Widget? trailing,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(context.scale(10)),
          decoration: BoxDecoration(
            color: context.colors.surface100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: context.colors.surface400),
        ),
        SizedBox(width: context.scale(12)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.colors.surface400,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: context.scaleHeight(4)),
              Text(
                value,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colors.surface900,
                  fontWeight: FontWeight.w500,
                  fontSize: context.scaleFont(13),
                ),
              ),
            ],
          ),
        ),
        if (trailing != null) trailing,
      ],
    );
  }

  Widget _buildAcademicItem(
    BuildContext context,
    String label,
    String value, {
    bool isFullWidth = false,
    bool hasColorDot = false,
  }) {
    return SizedBox(
      width: isFullWidth
          ? double.infinity
          : MediaQuery.of(context).size.width * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colors.surface400,
              fontWeight: FontWeight.w600,
              fontSize: context.scaleFont(11),
            ),
          ),
          SizedBox(height: context.scaleHeight(4)),
          Row(
            children: [
              if (hasColorDot)
                Container(
                  margin: EdgeInsets.only(right: context.scale(6)),
                  width: context.scale(8),
                  height: context.scale(8),
                  decoration: BoxDecoration(
                    color: context.colors.warning,
                    shape: BoxShape.circle,
                  ),
                ),
              Flexible(
                child: Text(
                  value,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colors.surface900,
                    fontWeight: FontWeight.w600,
                    fontSize: context.scaleFont(13),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
