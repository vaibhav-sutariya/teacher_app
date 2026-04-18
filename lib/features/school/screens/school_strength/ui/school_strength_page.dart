import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';
import '../bloc/school_strength_bloc.dart';
import 'widgets/strength_metric_widgets.dart';

@RoutePage()
class SchoolStrengthPage extends StatelessWidget {
  const SchoolStrengthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SchoolStrengthBloc()..add(LoadSchoolStrength()),
      child: const _SchoolStrengthPageContent(),
    );
  }
}

class _SchoolStrengthPageContent extends StatelessWidget {
  const _SchoolStrengthPageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface100,
      appBar: AppAppBar(
        title: 'School Strength',
        backgroundColor: context.colors.primary,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<SchoolStrengthBloc, SchoolStrengthState>(
        builder: (context, state) {
          if (state is SchoolStrengthLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SchoolStrengthLoaded) {
            final strength = state.strength;
            return SingleChildScrollView(
              padding: EdgeInsets.all(context.scale(16)),
              child: Column(
                children: [
                  // 1. Total Students Section
                  SummaryCard(
                    title: 'Total Students',
                    value: strength.totalStudents.toString(),
                    backgroundColor: const Color(
                      0xFFAC92CC,
                    ), // Purple shade from image
                  ),
                  SizedBox(height: context.scaleHeight(15)),

                  // 2. Girls & Boys section
                  GenderSplitCard(
                    girlsCount: strength.girlsCount,
                    boysCount: strength.boysCount,
                    backgroundColor: const Color(
                      0xFFFF7253,
                    ), // Orange shade from image
                  ),
                  SizedBox(height: context.scaleHeight(25)),

                  // 3. Detail Metrics Section
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(context.scale(12)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(context.scale(12)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: DetailMetricBox(
                                  label: 'ACTIVE',
                                  value: strength.activeCount.toString(),
                                  textColor: const Color(0xFFF57C00), // Orange
                                ),
                              ),
                              Expanded(
                                child: DetailMetricBox(
                                  label: 'PROMOTED',
                                  value: strength.promotedCount.toString(),
                                  textColor: const Color(0xFF7B1FA2), // Purple
                                ),
                              ),
                              Expanded(
                                child: DetailMetricBox(
                                  label: 'NEW',
                                  value: strength.newCount.toString(),
                                  textColor: const Color(0xFF388E3C), // Green
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: DetailMetricBox(
                                  label: 'RTE',
                                  value: strength.rteCount.toString(),
                                  textColor: const Color(0xFFFBC02D), // Yellow
                                ),
                              ),
                              Expanded(
                                child: DetailMetricBox(
                                  label: 'LEFT',
                                  value: strength.leftCount.toString(),
                                  textColor: const Color(0xFFD32F2F), // Red
                                ),
                              ),
                              Expanded(
                                child: DetailMetricBox(
                                  label: 'CANCEL',
                                  value: strength.cancelCount.toString(),
                                  textColor: const Color(0xFF1976D2), // Blue
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is SchoolStrengthError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
