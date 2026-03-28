import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../core/routes/app_router.gr.dart';
import '../../../../core/widgets/app_app_bar.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../cubit/theme_cubit.dart';
import '../bloc/exam_time_table_bloc.dart';
import 'widgets/exam_time_table_card.dart';

@RoutePage()
class ExamTimeTablePage extends StatelessWidget {
  const ExamTimeTablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExamTimeTableBloc(repository: sl.get())..add(LoadExamTimeTable()),
      child: Scaffold(
        backgroundColor: context.colors.surface100,
        appBar: const AppAppBar(title: 'Exam Time Table'),
        body: BlocBuilder<ExamTimeTableBloc, ExamTimeTableState>(
          builder: (context, state) {
            if (state is ExamTimeTableLoading) {
              return const Center(child: AppLoader());
            } else if (state is ExamTimeTableLoaded) {
              if (state.examTimeTables.isEmpty) {
                return _EmptyState();
              }

              return ListView.builder(
                padding: EdgeInsets.all(context.scale(16)),
                itemCount: state.examTimeTables.length,
                itemBuilder: (context, index) {
                  final timetable = state.examTimeTables[index];
                  return ExamTimeTableCard(timetable: timetable);
                },
              );
            } else if (state is ExamTimeTableError) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(context.scale(20)),
                  child: Text(
                    state.message,
                    style: TextStyle(color: context.colors.error),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            onPressed: () async {
              await context.router.push(const AddExamTimeTableRoute());
              if (context.mounted) {
                context.read<ExamTimeTableBloc>().add(LoadExamTimeTable());
              }
            },
            backgroundColor: context.colors.primary,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_note_outlined,
            size: context.scale(64),
            color: Colors.grey.withValues(alpha: 0.5),
          ),
          SizedBox(height: context.scaleHeight(16)),
          Text(
            'No Exam Time Tables Available',
            style: TextStyle(
              fontSize: context.scaleFont(16),
              color: context.colors.textTertiary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
