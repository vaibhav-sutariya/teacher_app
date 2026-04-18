import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/di/injection.dart';
import '../../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../../core/routes/app_router.gr.dart';
import '../../../../../../core/widgets/app_app_bar.dart';
import '../../../../../../core/widgets/app_loader.dart';
import '../../../../../../cubit/theme_cubit.dart';
import '../bloc/time_table_bloc.dart';
import 'widgets/time_table_card.dart';

@RoutePage()
class TimeTablePage extends StatelessWidget implements AutoRouteWrapper {
  const TimeTablePage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TimeTableBloc(repository: sl.get())..add(LoadTimeTables()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface,
      appBar: const AppAppBar(title: 'Timetable'),
      body: BlocBuilder<TimeTableBloc, TimeTableState>(
        buildWhen: (previous, current) =>
            current is TimeTableLoading ||
            current is TimeTableLoaded ||
            current is TimeTableError,
        builder: (context, state) {
          if (state is TimeTableLoading) {
            return const AppLoader();
          } else if (state is TimeTableError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: context.colors.error),
                  ),
                  SizedBox(height: context.scaleHeight(16)),
                  TextButton(
                    onPressed: () {
                      context.read<TimeTableBloc>().add(LoadTimeTables());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (state is TimeTableLoaded) {
            if (state.timetables.isEmpty) {
              return Center(
                child: Text(
                  'No timetables found.',
                  style: TextStyle(color: context.colors.textSecondary),
                ),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: context.scaleHeight(8)),
              itemCount: state.timetables.length,
              itemBuilder: (context, index) {
                return TimeTableCard(timetable: state.timetables[index]);
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await context.router.push(const AddTimeTableRoute());
          if (context.mounted) {
            context.read<TimeTableBloc>().add(LoadTimeTables());
          }
        },
        backgroundColor: context.colors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
