import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../core/widgets/app_app_bar.dart';
import '../../../../../core/widgets/app_loader.dart';
import '../../../../../core/widgets/error_state.dart';
import '../../../../../cubit/theme_cubit.dart';
import '../models/transport_route_model.dart';
import 'bloc/view_transport_attendance_detail_bloc.dart';
import 'widgets/view_transport_student_card.dart';

@RoutePage()
class ViewTransportAttendanceDetailPage extends StatelessWidget {
  final TransportRouteModel routeModel;
  final DateTime date;

  const ViewTransportAttendanceDetailPage({
    super.key,
    required this.routeModel,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ViewTransportAttendanceDetailBloc()
            ..add(LoadTransportDetailsEvent(route: routeModel, date: date)),
      child: _ViewTransportAttendanceDetailContent(
        routeModel: routeModel,
        date: date,
      ),
    );
  }
}

class _ViewTransportAttendanceDetailContent extends StatelessWidget {
  final TransportRouteModel routeModel;
  final DateTime date;

  const _ViewTransportAttendanceDetailContent({
    required this.routeModel,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      ViewTransportAttendanceDetailBloc,
      ViewTransportAttendanceDetailState
    >(
      // Only rebuild if critical loaded states shift
      buildWhen: (previous, current) =>
          previous.isLoading != current.isLoading ||
          previous.errorMessage != current.errorMessage,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: context.colors.surface100,
          appBar: const AppAppBar(title: 'Route Details'),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Info Header
              Container(
                color: context.colors.surface,
                padding: EdgeInsets.symmetric(
                  horizontal: context.scale(16),
                  vertical: context.scaleHeight(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            routeModel.routeName.toUpperCase(),
                            style: TextStyle(
                              fontSize: context.scaleFont(16),
                              fontWeight: FontWeight.bold,
                              color: context.colors.primary,
                            ),
                          ),
                          SizedBox(height: context.scaleHeight(4)),
                          Text(
                            'Vehicle: ${routeModel.vehicleNumber}',
                            style: TextStyle(
                              fontSize: context.scaleFont(14),
                              color: context.colors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.scale(12),
                        vertical: context.scaleHeight(6),
                      ),
                      decoration: BoxDecoration(
                        color: context.colors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(context.scale(12)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: context.scale(14),
                            color: context.colors.primary,
                          ),
                          SizedBox(width: context.scale(6)),
                          Text(
                            DateFormat('dd MMM yyyy').format(date),
                            style: TextStyle(
                              fontSize: context.scaleFont(14),
                              fontWeight: FontWeight.bold,
                              color: context.colors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1, color: context.colors.divider),

              // Student List or Loader
              Expanded(child: _buildBody(context, state)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    ViewTransportAttendanceDetailState state,
  ) {
    if (state.isLoading) {
      return const Center(child: AppLoader());
    }

    if (state.errorMessage != null) {
      return ErrorState(
        message: state.errorMessage!,
        onRetry: () => context.read<ViewTransportAttendanceDetailBloc>().add(
          LoadTransportDetailsEvent(route: routeModel, date: date),
        ),
      );
    }

    if (state.students.isEmpty) {
      return Center(
        child: Text(
          'No students mapped to this route.',
          style: TextStyle(
            color: context.colors.textSecondary,
            fontSize: context.scaleFont(16),
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: state.students.length,
      itemBuilder: (context, index) {
        return ViewTransportStudentCard(student: state.students[index]);
      },
    );
  }
}
