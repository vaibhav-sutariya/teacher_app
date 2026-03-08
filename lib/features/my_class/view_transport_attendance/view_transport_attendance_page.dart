import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import 'bloc/view_transport_attendance_bloc.dart';
import 'widgets/view_transport_attendance_card.dart';

@RoutePage()
class ViewTransportAttendancePage extends StatelessWidget {
  const ViewTransportAttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ViewTransportAttendanceBloc()..add(LoadViewTransportAttendance()),
      child: Scaffold(
        backgroundColor: context.colors.surface,
        appBar: AppBar(
          backgroundColor: context.colors.primary,
          title: Text(
            'View Transport Attendance',
            style: TextStyle(color: context.colors.textInverse),
          ),
          iconTheme: IconThemeData(color: context.colors.textInverse),
        ),
        body:
            BlocBuilder<
              ViewTransportAttendanceBloc,
              ViewTransportAttendanceState
            >(
              builder: (context, state) {
                if (state is ViewTransportAttendanceLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ViewTransportAttendanceLoaded) {
                  return ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) =>
                        const ViewTransportAttendanceCard(),
                  );
                } else if (state is ViewTransportAttendanceError) {
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
