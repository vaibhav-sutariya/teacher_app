import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../core/widgets/app_app_bar.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../cubit/theme_cubit.dart';
import 'bloc/notification_bloc.dart';
import 'bloc/notification_event.dart';
import 'bloc/notification_state.dart';
import 'widgets/notification_card.dart';

@RoutePage()
class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationBloc()..add(LoadNotifications()),
      child: Scaffold(
        backgroundColor: context.colors.background,
        appBar: const AppAppBar(title: 'Notifications'),
        body: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            if (state is NotificationLoading || state is NotificationInitial) {
              return const Center(child: AppLoader());
            }

            if (state is NotificationError) {
              return Center(
                child: Text(
                  state.message,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.colors.error,
                  ),
                ),
              );
            }

            if (state is NotificationLoaded) {
              if (state.groupedNotifications.isEmpty) {
                return Center(
                  child: Text(
                    'No notifications yet',
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: context.colors.surface500,
                    ),
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.all(context.scale(20)),
                itemCount: state.groupedNotifications.length,
                itemBuilder: (context, index) {
                  final groupDate = state.groupedNotifications.keys.elementAt(
                    index,
                  );
                  final notificationsInGroup =
                      state.groupedNotifications[groupDate]!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: context.scaleHeight(12),
                          top: index > 0 ? context.scaleHeight(12) : 0,
                        ),
                        child: Text(
                          groupDate,
                          style: context.textTheme.labelMedium?.copyWith(
                            color: context.colors.surface600,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      ...notificationsInGroup.map((notification) {
                        return NotificationCard(notification: notification);
                      }),
                    ],
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
