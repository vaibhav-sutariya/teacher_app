import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';
import '../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../core/widgets/app_loader.dart';
import '../my_class/my_class_screen/widgets/my_class_header.dart';
import 'bloc/home_bloc.dart';
import 'bloc/home_event.dart';
import 'bloc/home_state.dart';
import 'widgets/dashboard_cards.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(LoadDashboardData()),
      child: const DashboardView(),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      body: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          if (state.status == HomeStatus.initial ||
              state.status == HomeStatus.loading) {
            return const Center(child: AppLoader());
          }

          if (state.status == HomeStatus.error) {
            return Center(
              child: Text(state.errorMessage ?? 'An error occurred'),
            );
          }

          return Stack(
            children: [
              // Header Background
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
                    SizedBox(height: context.scaleHeight(20)),

                    // Scrollable Cards
                    Expanded(
                      child: CustomScrollView(
                        slivers: [
                          const SliverToBoxAdapter(child: CheckInCard()),
                          const SliverToBoxAdapter(child: EventsCard()),
                          const SliverToBoxAdapter(child: AnnouncementsCard()),
                          const SliverToBoxAdapter(child: BirthdaysCard()),
                          const SliverToBoxAdapter(child: PendingLeavesCard()),
                          const SliverToBoxAdapter(child: AttendanceCard()),
                          const SliverToBoxAdapter(child: HomeworkCard()),

                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: context.scaleHeight(100),
                            ), // Bottom padding
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
