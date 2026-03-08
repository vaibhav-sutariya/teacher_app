import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';

import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/widgets/reusable_calendar_strip.dart';
import 'bloc/subject_wise_homework_bloc.dart';
import 'bloc/subject_wise_homework_event.dart';
import 'bloc/subject_wise_homework_state.dart';
import '../../../../core/routes/app_router.gr.dart';

@RoutePage()
class SubjectWiseHomeworkPage extends StatelessWidget {
  const SubjectWiseHomeworkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SubjectWiseHomeworkBloc()..add(SubjectWiseHomeworkLoaded()),
      child: const _SubjectWiseHomeworkPageContent(),
    );
  }
}

class _SubjectWiseHomeworkPageContent extends StatelessWidget {
  const _SubjectWiseHomeworkPageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppAppBar(title: 'Subject wise Homework'),
      body: Column(
        children: [
          // Calendar Strip
          BlocSelector<
            SubjectWiseHomeworkBloc,
            SubjectWiseHomeworkState,
            DateTime
          >(
            selector: (state) {
              if (state is SubjectWiseHomeworkLoadedState)
                return state.selectedDate;
              return DateTime.now();
            },
            builder: (context, selectedDate) {
              return ReusableCalendarStrip(
                selectedDate: selectedDate,
                onDateSelected: (date) {
                  context.read<SubjectWiseHomeworkBloc>().add(
                    SubjectWiseHomeworkDateChanged(date),
                  );
                },
                disableFutureDates: false,
              );
            },
          ),

          Expanded(
            child:
                BlocBuilder<SubjectWiseHomeworkBloc, SubjectWiseHomeworkState>(
                  builder: (context, state) {
                    if (state is SubjectWiseHomeworkLoading) {
                      return const Center(
                        child: AppLoader(color: Color(0xFFFFB300)),
                      );
                    } else if (state is SubjectWiseHomeworkLoadedState) {
                      return ListView.separated(
                        itemCount: state.classes.length,
                        separatorBuilder: (context, index) =>
                            const Divider(height: 1, color: Color(0xFFF3F4F6)),
                        itemBuilder: (context, index) {
                          final className = state.classes[index];
                          return ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: context.scale(20),
                              vertical: context.scaleHeight(4),
                            ),
                            title: Text(
                              className,
                              style: TextStyle(
                                fontSize: context.scaleFont(14),
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF111827),
                                letterSpacing: 0.5,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: context.scale(16),
                              color: const Color(0xFF111827),
                            ),
                            onTap: () {
                              final selectedDate =
                                  (context.read<SubjectWiseHomeworkBloc>().state
                                          as SubjectWiseHomeworkLoadedState)
                                      .selectedDate;
                              context.router.push(
                                SubjectWiseHomeworkSubjectRoute(
                                  className: className,
                                  selectedDate: selectedDate,
                                ),
                              );
                            },
                          );
                        },
                      );
                    } else if (state is SubjectWiseHomeworkError) {
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
