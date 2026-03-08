import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';
import 'package:teachers_app/core/widgets/app_loader.dart';
import 'package:teachers_app/core/widgets/reusable_calendar_strip.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';
import 'package:teachers_app/core/routes/app_router.gr.dart';

import 'bloc/classwork_classes_bloc.dart';
import 'bloc/classwork_classes_event.dart';
import 'bloc/classwork_classes_state.dart';

@RoutePage()
class ClassworkClassesPage extends StatelessWidget {
  const ClassworkClassesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ClassworkClassesBloc()..add(ClassworkClassesLoaded()),
      child: const _ClassworkClassesContent(),
    );
  }
}

class _ClassworkClassesContent extends StatelessWidget {
  const _ClassworkClassesContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppAppBar(title: 'Class Work'),
      body: Column(
        children: [
          // Calendar Strip - Optimized with BlocSelector
          BlocSelector<ClassworkClassesBloc, ClassworkClassesState, DateTime>(
            selector: (state) {
              if (state is ClassworkClassesLoadedState)
                return state.selectedDate;
              return DateTime.now();
            },
            builder: (context, selectedDate) {
              return ReusableCalendarStrip(
                selectedDate: selectedDate,
                onDateSelected: (date) {
                  context.read<ClassworkClassesBloc>().add(
                    ClassworkClassesDateChanged(date),
                  );
                },
                disableFutureDates: true,
              );
            },
          ),

          Expanded(
            child: BlocBuilder<ClassworkClassesBloc, ClassworkClassesState>(
              builder: (context, state) {
                if (state is ClassworkClassesLoading) {
                  return const Center(child: AppLoader());
                } else if (state is ClassworkClassesLoadedState) {
                  return ListView.separated(
                    itemCount: state.classes.length,
                    separatorBuilder: (context, index) =>
                        Divider(height: 1, color: context.colors.divider),
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
                          // TODO: Navigate to ClassworkSubjectRoute
                          context.router.push(
                            ClassworkSubjectRoute(
                              className: className,
                              selectedDate: state.selectedDate,
                            ),
                          );
                        },
                      );
                    },
                  );
                } else if (state is ClassworkClassesError) {
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
