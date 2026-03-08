import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import 'bloc/calendar_bloc.dart';
import 'widgets/calendar_card.dart';

@RoutePage()
class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalendarBloc()..add(LoadCalendar()),
      child: Scaffold(
        backgroundColor: context.colors.surface,
        appBar: AppBar(
          backgroundColor: context.colors.primary,
          title: Text(
            'Calendar',
            style: TextStyle(color: context.colors.textInverse),
          ),
          iconTheme: IconThemeData(color: context.colors.textInverse),
        ),
        body: BlocBuilder<CalendarBloc, CalendarState>(
          builder: (context, state) {
            if (state is CalendarLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CalendarLoaded) {
              return ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) => const CalendarCard(),
              );
            } else if (state is CalendarError) {
              return Center(
                child: Text(
                  state.message,
                  style: TextStyle(color: context.colors.error),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
