import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/helpers/extensions/responsive_extensions.dart';
import '../../core/widgets/app_loader.dart';
import '../../cubit/theme_cubit.dart';
import 'bloc/school_bloc.dart';
import 'widgets/school_widgets.dart';

@RoutePage()
class SchoolPage extends StatelessWidget {
  const SchoolPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SchoolBloc()..add(LoadSchoolData()),
      child: Scaffold(
        backgroundColor: context.colors.background,
        body: BlocBuilder<SchoolBloc, SchoolState>(
          builder: (context, state) {
            if (state is SchoolLoading) {
              return const Center(child: AppLoader());
            }

            if (state is SchoolError) {
              return Center(child: Text(state.message));
            }

            if (state is SchoolLoaded) {
              final summary = state.summary;
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<SchoolBloc>().add(RefreshSchoolData());
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SchoolHeader(model: summary.header),
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
