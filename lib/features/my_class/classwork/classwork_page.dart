import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../core/widgets/app_app_bar.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../core/widgets/end_of_list_indicator.dart';
import '../../../core/widgets/reusable_calendar_strip.dart';
import 'bloc/classwork_bloc.dart';
import 'widgets/classwork_card.dart';

@RoutePage()
class ClassworkPage extends StatelessWidget {
  const ClassworkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClassworkBloc()..add(ClassworkLoaded()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: const AppAppBar(title: 'Class Work'),
        body: Column(
          children: [
            // Calendar Strip - Optimized with BlocSelector
            BlocSelector<ClassworkBloc, ClassworkState, DateTime>(
              selector: (state) {
                if (state is ClassworkLoadedState) return state.selectedDate;
                return DateTime.now(); // Fallback/Initial
              },
              builder: (context, selectedDate) {
                return ReusableCalendarStrip(
                  selectedDate: selectedDate,
                  onDateSelected: (date) {
                    context.read<ClassworkBloc>().add(
                      ClassworkDateChanged(date),
                    );
                  },
                  disableFutureDates: true,
                );
              },
            ),

            SizedBox(height: context.scaleHeight(16)),

            // Classwork List
            Expanded(
              child:
                  BlocSelector<ClassworkBloc, ClassworkState, ClassworkState>(
                    selector: (state) => state,
                    builder: (context, state) {
                      if (state is ClassworkLoading) {
                        return const AppLoader();
                      } else if (state is ClassworkLoadedState) {
                        if (state.classworkList.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.assignment_outlined,
                                  size: context.scale(64),
                                  color: Colors.grey.withValues(alpha: 0.5),
                                ),
                                SizedBox(height: context.scaleHeight(16)),
                                Text(
                                  'No Class Work Assigned',
                                  style: TextStyle(
                                    fontSize: context.scaleFont(16),
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return ListView.builder(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.scale(16),
                          ),
                          itemCount:
                              state.classworkList.length +
                              1, // +1 for "reached end"
                          itemBuilder: (context, index) {
                            if (index == state.classworkList.length) {
                              return const EndOfListIndicator();
                            }
                            return ClassworkCard(
                              classwork: state.classworkList[index],
                            );
                          },
                        );
                      } else if (state is ClassworkError) {
                        return Center(child: Text(state.message));
                      }
                      return const SizedBox.shrink();
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
