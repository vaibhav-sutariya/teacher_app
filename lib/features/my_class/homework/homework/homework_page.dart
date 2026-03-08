import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';

import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/widgets/reusable_calendar_strip.dart';
import 'bloc/homework_bloc.dart';
import 'bloc/homework_event.dart';
import 'bloc/homework_state.dart';
import '../../../../core/routes/app_router.gr.dart';

@RoutePage()
class HomeworkPage extends StatelessWidget {
  const HomeworkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeworkBloc()..add(HomeworkLoaded()),
      child: const _HomeworkPageContent(),
    );
  }
}

class _HomeworkPageContent extends StatelessWidget {
  const _HomeworkPageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppAppBar(title: 'Homework'),
      body: Column(
        children: [
          // Calendar Strip
          BlocSelector<HomeworkBloc, HomeworkState, DateTime>(
            selector: (state) {
              if (state is HomeworkLoadedState) return state.selectedDate;
              return DateTime.now();
            },
            builder: (context, selectedDate) {
              return ReusableCalendarStrip(
                selectedDate: selectedDate,
                onDateSelected: (date) {
                  context.read<HomeworkBloc>().add(HomeworkDateChanged(date));
                },
                disableFutureDates: false,
              );
            },
          ),

          Expanded(
            child: BlocBuilder<HomeworkBloc, HomeworkState>(
              builder: (context, state) {
                if (state is HomeworkLoading) {
                  return const Center(
                    child: AppLoader(color: Color(0xFFFFB300)),
                  );
                } else if (state is HomeworkLoadedState) {
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
                              (context.read<HomeworkBloc>().state
                                      as HomeworkLoadedState)
                                  .selectedDate;
                          context.router.push(
                            HomeworkEntryRoute(
                              className: className,
                              selectedDate: selectedDate,
                            ),
                          );
                        },
                      );
                    },
                  );
                } else if (state is HomeworkError) {
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
