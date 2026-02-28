import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../core/widgets/app_app_bar.dart';
import '../../../../../core/widgets/app_loader.dart';
import '../../../../../core/widgets/app_pdf_viewer.dart';
import '../bloc/time_table_bloc.dart';

@RoutePage()
class TimeTablePage extends StatelessWidget implements AutoRouteWrapper {
  const TimeTablePage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TimeTableBloc(repository: sl.get())..add(LoadTimeTable()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(title: 'Time Table'),
      body: BlocBuilder<TimeTableBloc, TimeTableState>(
        builder: (context, state) {
          if (state is TimeTableLoading) {
            return const AppLoader();
          } else if (state is TimeTableError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message, textAlign: TextAlign.center),
                  TextButton(
                    onPressed: () {
                      context.read<TimeTableBloc>().add(LoadTimeTable());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (state is TimeTableLoaded) {
            return AppPdfViewer(filePath: state.filePath);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
