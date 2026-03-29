import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';
import 'package:teachers_app/core/routes/app_router.gr.dart';
import '../../my_class/my_class_screen/widgets/menu_item.dart';
import '../../my_class/my_class_screen/widgets/my_class_header.dart';
import 'bloc/service_bloc.dart';
import 'widgets/service_search_bar.dart';

@RoutePage()
class ServicePage extends StatelessWidget {
  const ServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServiceBloc()..add(LoadServiceData()),
      child: Scaffold(
        backgroundColor: context.colors.surface100,
        body: Stack(
          children: [
            // Blue Header Background with Bottom Radius
            Container(
              height: context.scaleHeight(185),
              decoration: BoxDecoration(
                color: context.colors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(context.scale(20)),
                  bottomRight: Radius.circular(context.scale(20)),
                ),
              ),
            ),

            // Content
            SafeArea(
              bottom: false,
              child: Column(
                children: [
                  SizedBox(height: context.scaleHeight(5)),
                  // Header
                  const MyClassHeader(),
                  SizedBox(height: context.scaleHeight(12)),
                  // Search Bar
                  const ServiceSearchBar(),
                  SizedBox(height: context.scaleHeight(12)),

                  // Grid Section wrapped in a Card
                  Expanded(
                    child: BlocBuilder<ServiceBloc, ServiceState>(
                      builder: (context, state) {
                        if (state is ServiceLoaded) {
                          final items = state.filteredItems;

                          if (items.isEmpty) {
                            return Center(
                              child: Text(
                                'No results found',
                                style: TextStyle(
                                  color: context.colors.textSecondary,
                                  fontSize: context.scaleFont(14),
                                ),
                              ),
                            );
                          }

                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.scale(14),
                            ),
                            child: SingleChildScrollView(
                              child: Card(
                                color: context.colors.textInverse,
                                elevation: 2,
                                shadowColor: Colors.black.withValues(
                                  alpha: 0.1,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    context.scale(16),
                                  ),
                                  side: BorderSide(
                                    color: Colors.grey.withValues(alpha: 0.08),
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(context.scale(16)),
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          mainAxisSpacing: context.scaleHeight(
                                            8,
                                          ),
                                          crossAxisSpacing: context.scale(22),
                                          childAspectRatio:
                                              1.05, // Reduced height (wider items)
                                        ),
                                    itemCount: items.length,
                                    itemBuilder: (context, index) {
                                      final item = state.items[index];
                                      return MenuItem(
                                        icon: item.icon,
                                        label: item.label,
                                        color: item.iconColor,
                                        backgroundColor: item.backgroundColor,
                                        onTap: () {
                                          if (item.label == 'Leave') {
                                            context.pushRoute(
                                              const LeaveTrackerRoute(),
                                            );
                                          } else if (item.label ==
                                              'Approvals') {
                                            context.pushRoute(
                                              const ApprovalsRoute(),
                                            );
                                          } else if (item.label ==
                                              'Manual Punch') {
                                            context.pushRoute(
                                              const PunchTrackerRoute(),
                                            );
                                          } else if (item.label ==
                                              'Approve/Reject Manual Punch') {
                                            context.pushRoute(
                                              const PunchApprovalsRoute(),
                                            );
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else if (state is ServiceError) {
                          return Center(child: Text(state.message));
                        }
                        // Default to empty if somehow state is initial or loading
                        return const SizedBox();
                      },
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
