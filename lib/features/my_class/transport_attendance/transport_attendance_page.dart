import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import 'bloc/transport_attendance_bloc.dart';
import 'widgets/transport_attendance_card.dart';

@RoutePage()
class TransportAttendancePage extends StatelessWidget {
  const TransportAttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TransportAttendanceBloc()..add(LoadTransportAttendance()),
      child: Scaffold(
        backgroundColor: context.colors.surface,
        appBar: AppBar(
          backgroundColor: context.colors.primary,
          title: Text(
            'Transport Attendance',
            style: TextStyle(color: context.colors.textInverse),
          ),
          iconTheme: IconThemeData(color: context.colors.textInverse),
        ),
        body: BlocBuilder<TransportAttendanceBloc, TransportAttendanceState>(
          builder: (context, state) {
            if (state is TransportAttendanceLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TransportAttendanceLoaded) {
              return ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) =>
                    const TransportAttendanceCard(),
              );
            } else if (state is TransportAttendanceError) {
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
