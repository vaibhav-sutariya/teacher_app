import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';
import 'package:teachers_app/core/widgets/empty_state_view.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';
import 'package:teachers_app/core/routes/app_router.gr.dart';

import '../../../models/announcement_model.dart';
import '../bloc/announcements_bloc.dart';

@RoutePage()
class AnnouncementsPage extends StatelessWidget {
  const AnnouncementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AnnouncementsBloc()..add(LoadAnnouncements()),
      child: Scaffold(
        backgroundColor: context.colors.surface100,
        appBar: AppAppBar(title: 'Announcements'),
        body: BlocBuilder<AnnouncementsBloc, AnnouncementsState>(
          builder: (context, state) {
            if (state is AnnouncementsLoading) {
              return Center(
                child: CircularProgressIndicator(color: context.colors.primary),
              );
            } else if (state is AnnouncementsLoaded) {
              if (state.announcements.isEmpty) {
                return const EmptyStateView();
              }

              return ListView.builder(
                padding: EdgeInsets.all(context.scale(16)),
                itemCount: state.announcements.length,
                itemBuilder: (context, index) {
                  final announcement = state.announcements[index];
                  return _AnnouncementCard(announcement: announcement);
                },
              );
            } else if (state is AnnouncementsError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class _AnnouncementCard extends StatelessWidget {
  final AnnouncementModel announcement;

  const _AnnouncementCard({required this.announcement});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.scaleHeight(12)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.scale(8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(context.scale(8)),
          onTap: () {
            context.pushRoute(
              AnnouncementDetailsRoute(announcement: announcement),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(context.scale(12)),
            child: Row(
              children: [
                // Circular Date Indicator
                Container(
                  width: context.scale(55),
                  height: context.scale(55),
                  decoration: BoxDecoration(
                    color: announcement.dateColor,
                    shape: BoxShape.circle,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        announcement.day,
                        style: TextStyle(
                          fontSize: context.scaleFont(16),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        announcement.month,
                        style: TextStyle(
                          fontSize: context.scaleFont(12),
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: context.scale(16)),
                // Announcement Title
                Expanded(
                  child: Text(
                    announcement.title,
                    style: TextStyle(
                      fontSize: context.scaleFont(15),
                      fontWeight: FontWeight.w500,
                      color: context.colors.primary.withValues(alpha: 0.1),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
