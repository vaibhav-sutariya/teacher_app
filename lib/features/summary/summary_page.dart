import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/helpers/extensions/responsive_extensions.dart';
import '../../core/widgets/app_loader.dart';
import '../../cubit/theme_cubit.dart';
import 'bloc/summary_bloc.dart';
import 'widgets/summary_widgets.dart';

@RoutePage()
class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SummaryBloc()..add(LoadSummaryData()),
      child: Scaffold(
        backgroundColor: context.colors.background,
        body: BlocBuilder<SummaryBloc, SummaryState>(
          builder: (context, state) {
            if (state is SummaryLoading) {
              return const Center(child: AppLoader());
            }

            if (state is SummaryError) {
              return Center(child: Text(state.message));
            }

            if (state is SummaryLoaded) {
              final summary = state.summary;
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<SummaryBloc>().add(RefreshSummaryData());
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SummaryHeader(model: summary.header),
                      SizedBox(height: context.scaleHeight(20)),
                      AttendancePill(status: summary.attendanceStatus),
                      SizedBox(height: context.scaleHeight(24)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.scale(20),
                        ),
                        child: Divider(color: context.colors.surface200),
                      ),
                      SizedBox(height: context.scaleHeight(16)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.scale(20),
                        ),
                        child: Text(
                          'Top picks from Adademics',
                          style: context.textTheme.titleLarge?.copyWith(
                            color: context.colors.surface900,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: context.scaleHeight(16)),
                      ...summary.academicPicks.map(
                        (pick) => AcademicCard(model: pick),
                      ),
                      SizedBox(height: context.scaleHeight(16)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.scale(20),
                        ),
                        child: Divider(color: context.colors.surface200),
                      ),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
