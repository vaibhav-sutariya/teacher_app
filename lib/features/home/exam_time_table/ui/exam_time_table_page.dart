import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/widgets/app_app_bar.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/widgets/app_pdf_viewer.dart';
import '../bloc/exam_time_table_bloc.dart';

@RoutePage()
class ExamTimeTablePage extends StatelessWidget implements AutoRouteWrapper {
  const ExamTimeTablePage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ExamTimeTableBloc(repository: sl.get())..add(LoadExamTimeTable()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(title: 'Exam Time Table'),
      body: BlocBuilder<ExamTimeTableBloc, ExamTimeTableState>(
        builder: (context, state) {
          if (state is ExamTimeTableLoading) {
            return const AppLoader();
          } else if (state is ExamTimeTableError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        context.read<ExamTimeTableBloc>().add(
                          LoadExamTimeTable(),
                        );
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is ExamTimeTableLoaded) {
            return AppPdfViewer(filePath: state.filePath);
          }
          // Initial state
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
