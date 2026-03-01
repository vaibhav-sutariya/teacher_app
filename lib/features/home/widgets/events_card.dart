import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';
import '../models/dashboard_models.dart';
import 'dashboard_card.dart';

class EventsCard extends StatelessWidget {
  const EventsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, List<EventModel>>(
      selector: (state) => state.todayEvents,
      builder: (context, events) {
        return DashboardCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DashboardSectionTitle(
                icon: Icons.event_note,
                iconColor: Colors.deepPurple,
                title: "Today's Events",
              ),
              SizedBox(height: context.scaleHeight(16)),
              if (events.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: Text("No events today")),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final ev = events[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: context.scaleHeight(12)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.access_time_filled,
                            color: Colors.grey.shade400,
                            size: context.scale(18),
                          ),
                          SizedBox(width: context.scale(12)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ev.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: context.scaleFont(14),
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: context.scaleHeight(4)),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.schedule,
                                      size: context.scale(12),
                                      color: Colors.grey.shade600,
                                    ),
                                    SizedBox(width: context.scale(4)),
                                    Text(
                                      ev.time,
                                      style: TextStyle(
                                        fontSize: context.scaleFont(12),
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    SizedBox(width: context.scale(12)),
                                    Icon(
                                      Icons.location_on,
                                      size: context.scale(12),
                                      color: Colors.grey.shade600,
                                    ),
                                    SizedBox(width: context.scale(4)),
                                    Expanded(
                                      child: Text(
                                        ev.location,
                                        style: TextStyle(
                                          fontSize: context.scaleFont(12),
                                          color: Colors.grey.shade600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
