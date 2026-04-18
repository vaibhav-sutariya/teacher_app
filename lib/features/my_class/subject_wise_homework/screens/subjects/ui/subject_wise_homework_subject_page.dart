import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:teachers_app/core/routes/app_router.gr.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';
import 'package:teachers_app/core/widgets/app_loader.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import '../../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../bloc/subject_wise_homework_subject_bloc.dart';
import '../bloc/subject_wise_homework_subject_event.dart';
import '../bloc/subject_wise_homework_subject_state.dart';

@RoutePage()
class SubjectWiseHomeworkSubjectPage extends StatelessWidget {
  final String className;
  final DateTime selectedDate;

  const SubjectWiseHomeworkSubjectPage({
    super.key,
    required this.className,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SubjectWiseHomeworkSubjectBloc()..add(LoadSubjectsEvent(className)),
      child: _SubjectWiseHomeworkSubjectContent(
        className: className,
        selectedDate: selectedDate,
      ),
    );
  }
}

class _SubjectWiseHomeworkSubjectContent extends StatelessWidget {
  final String className;
  final DateTime selectedDate;

  const _SubjectWiseHomeworkSubjectContent({
    required this.className,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppAppBar(title: 'Homework'),
      body: Column(
        children: [
          // Header info
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.scale(20),
              vertical: context.scaleHeight(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  className.toUpperCase(),
                  style: TextStyle(
                    color: context.colors.primary,
                    fontSize: context.scaleFont(14),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  DateFormat('dd-MMM-yyyy').format(selectedDate),
                  style: TextStyle(
                    color: context.colors.primary,
                    fontSize: context.scaleFont(14),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: context.colors.divider),
          Expanded(
            child:
                BlocBuilder<
                  SubjectWiseHomeworkSubjectBloc,
                  SubjectWiseHomeworkSubjectState
                >(
                  builder: (context, state) {
                    if (state is SubjectWiseHomeworkSubjectLoading) {
                      return Center(
                        child: AppLoader(color: context.colors.warning),
                      );
                    } else if (state is SubjectWiseHomeworkSubjectLoaded) {
                      return ListView.separated(
                        itemCount: state.subjects.length,
                        separatorBuilder: (context, index) => Divider(
                          height: 1,
                          color: context.colors.surfaceMedium,
                        ),
                        itemBuilder: (context, index) {
                          final subjectName = state.subjects[index];
                          return ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: context.scale(20),
                              vertical: context.scaleHeight(4),
                            ),
                            title: Text(
                              subjectName,
                              style: TextStyle(
                                fontSize: context.scaleFont(14),
                                fontWeight: FontWeight.w600,
                                color: context.colors.textPrimary,
                                letterSpacing: 0.5,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: context.scale(16),
                              color: context.colors.textPrimary,
                            ),
                            onTap: () {
                              context.router.push(
                                SubjectWiseHomeworkEntryRoute(
                                  className: className,
                                  selectedDate: selectedDate,
                                  subjectName: subjectName,
                                ),
                              );
                            },
                          );
                        },
                      );
                    } else if (state is SubjectWiseHomeworkSubjectError) {
                      return Center(child: Text(state.message));
                    }
                    return const SizedBox.shrink();
                  },
                ),
          ),
        ],
      ),
    );
  }
}
