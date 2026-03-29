import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/features/my_class/my_class_screen/widgets/my_class_header.dart';

import 'bloc/school_bloc.dart';
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
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. Teal Header Background (Standard for MyClass suite)
          Container(
            height: context.scaleHeight(185),
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF00695C),
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
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(context.scale(25)),
                        topRight: Radius.circular(context.scale(25)),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 20,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(context.scale(25)),
                        topRight: Radius.circular(context.scale(25)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: context.scale(20)),
                          // Modules List (Tightened for single-screen fit)
                          Expanded(
                            child: BlocBuilder<SchoolBloc, SchoolState>(
                              builder: (context, state) {
                                if (state.status ==
                                    SchoolManagementStatus.loading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                if (state.status ==
                                    SchoolManagementStatus.error) {
                                  return Center(
                                    child: Text(
                                      state.errorMessage ??
                                          'Error Loading Dashboard',
                                    ),
                                  );
                                }

                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  physics:
                                      const NeverScrollableScrollPhysics(), // Non-scrollable singleton view
                                  itemCount: state.modules.length,
                                  itemBuilder: (context, index) {
                                    final module = state.modules[index];
                                    return SchoolManagementListTile(
                                      module: module,
                                      onTap: () {
                                        // TODO: Implement navigation
                                      },
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
