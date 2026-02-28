import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/annotations.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../core/widgets/app_app_bar.dart';
import '../../../../core/widgets/app_loader.dart';
import 'bloc/achievement_bloc.dart';
import 'bloc/achievement_event.dart';
import 'bloc/achievement_state.dart';
import 'widgets/achievement_card.dart';

@RoutePage()
class AchievementPage extends StatelessWidget {
  const AchievementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AchievementBloc()..add(LoadAchievements()),
      child: Scaffold(
        appBar: const AppAppBar(title: 'Achievements'),
        body: BlocBuilder<AchievementBloc, AchievementState>(
          builder: (context, state) {
            if (state is AchievementLoading || state is AchievementInitial) {
              return const Center(child: AppLoader());
            } else if (state is AchievementLoaded) {
              if (state.achievements.isEmpty) {
                return const Center(child: Text('No achievements yet.'));
              }

              return ListView.builder(
                padding: EdgeInsets.all(context.scale(20)),
                itemCount: state.achievements.length,
                itemBuilder: (context, index) {
                  final achievement = state.achievements[index];
                  return AchievementCard(achievement: achievement);
                },
              );
            } else if (state is AchievementError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
