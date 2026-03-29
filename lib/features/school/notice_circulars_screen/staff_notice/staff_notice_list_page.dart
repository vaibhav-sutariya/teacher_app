import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/core/routes/app_router.gr.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import 'bloc/staff_notice_bloc.dart';
import 'models/staff_notice_model.dart';

@RoutePage()
class StaffNoticeListPage extends StatelessWidget {
  const StaffNoticeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StaffNoticeBloc()..add(LoadStaffNotices()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: context.colors.surface100,
            appBar: AppAppBar(title: 'Staff Notice'),
            body: BlocBuilder<StaffNoticeBloc, StaffNoticeState>(
              builder: (context, state) {
                if (state is StaffNoticeLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is StaffNoticeLoaded) {
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.scale(16),
                      vertical: context.scaleHeight(10),
                    ),
                    itemCount: state.notices.length,
                    itemBuilder: (context, index) {
                      return StaffNoticeCard(notice: state.notices[index]);
                    },
                  );
                } else if (state is StaffNoticeError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox();
              },
            ),
            floatingActionButton: _buildFAB(context),
          );
        },
      ),
    );
  }

  Widget _buildFAB(BuildContext context) {
    return Container(
      width: context.scale(56),
      height: context.scale(56),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [context.colors.warning, context.colors.warningDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            final result = await context.router.push(
              const AddStaffNoticeRoute(),
            );
            if (result == true && context.mounted) {
              context.read<StaffNoticeBloc>().add(LoadStaffNotices());
            }
          },
          customBorder: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white, size: 30),
        ),
      ),
    );
  }
}

class StaffNoticeCard extends StatelessWidget {
  final StaffNoticeModel notice;

  const StaffNoticeCard({super.key, required this.notice});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.scaleHeight(12)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.scale(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () =>
            context.router.push(StaffNoticeDetailsRoute(notice: notice)),
        borderRadius: BorderRadius.circular(context.scale(12)),
        child: Padding(
          padding: EdgeInsets.all(context.scale(12)),
          child: Row(
            children: [
              // Date Circle
              Container(
                width: context.scale(50),
                height: context.scale(50),
                decoration: BoxDecoration(
                  color: notice.iconColor ?? Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat('dd').format(notice.date),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      DateFormat('MMM').format(notice.date),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
              SizedBox(width: context.scale(16)),
              // Title
              Expanded(
                child: Text(
                  notice.title,
                  style: TextStyle(
                    fontSize: context.scaleFont(14),
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
