import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/core/routes/app_router.gr.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';
import 'package:teachers_app/features/my_class/my_class_screen/widgets/my_class_header.dart';

import 'bloc/school_bloc.dart';
import 'models/school_model.dart';
import 'widgets/school_management_list_tile.dart';

@RoutePage()
class SchoolPage extends StatelessWidget {
  const SchoolPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SchoolBloc()..add(LoadSchoolModules()),
      child: const _SchoolPageContent(),
    );
  }
}

class _SchoolPageContent extends StatelessWidget {
  const _SchoolPageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface100,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // 1. Teal Header Background
            Container(
              height: context.scaleHeight(185),
              width: double.infinity,
              decoration: BoxDecoration(
                color: context.colors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(context.scale(20)),
                  bottomRight: Radius.circular(context.scale(20)),
                ),
              ),
            ),

            // 2. Main content wrapping MyClassHeader and Modules List
            SafeArea(
              bottom: false,
              child: Column(
                children: [
                  SizedBox(height: context.scaleHeight(10)),
                  // Synchronized MyClassHeader
                  const MyClassHeader(),

                  SizedBox(height: context.scaleHeight(15)),

                  // Content Card
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(
                      context.scale(16),
                    ).copyWith(bottom: context.scaleHeight(100)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(context.scale(25)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(context.scale(25)),
                      child:
                          BlocSelector<
                            SchoolBloc,
                            SchoolState,
                            List<SchoolModuleModel>
                          >(
                            selector: (state) => state.modules,
                            builder: (context, modules) {
                              return ListView.separated(
                                padding: EdgeInsets.symmetric(
                                  vertical: context.scale(20),
                                ),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: modules.length,
                                separatorBuilder: (context, index) => Divider(
                                  color: Colors.grey.withValues(alpha: 0.05),
                                  height: 1,
                                  indent: context.scale(20),
                                  endIndent: context.scale(20),
                                ),
                                itemBuilder: (context, index) {
                                  final module = modules[index];
                                  return SchoolManagementListTile(
                                    module: module,
                                    onTap: () {
                                      if (module.id == 'fees') {
                                        context.router.push(const FeesRoute());
                                      } else if (module.id == 'staff_attendance') {
                                        context.router.push(const StaffAttendanceRoute());
                                      } else if (module.id == 'staff_details') {
                                        context.router.push(const StaffDetailsRoute());
                                      } else if (module.id == 'notice') {
                                        context.router.push(const NoticeCircularsRoute());
                                      } else if (module.id == 'enquiry') {
                                        context.router.push(const EnquiryRoute());
                                      }
                                    },
                                  );
                                },
                              );
                            },
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
