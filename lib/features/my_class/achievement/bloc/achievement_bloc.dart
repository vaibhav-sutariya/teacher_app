import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/achievement_model.dart';
import 'achievement_event.dart';
import 'achievement_state.dart';

class AchievementBloc extends Bloc<AchievementEvent, AchievementState> {
  AchievementBloc() : super(AchievementInitial()) {
    on<LoadAchievements>(_onLoadAchievements);
  }

  Future<void> _onLoadAchievements(
    LoadAchievements event,
    Emitter<AchievementState> emit,
  ) async {
    emit(AchievementLoading());
    try {
      // Simulating network delay
      await Future.delayed(const Duration(milliseconds: 600));

      final achievements = AchievementModel.getMockData();
      emit(AchievementLoaded(achievements: achievements));
    } catch (e) {
      emit(AchievementError(e.toString()));
    }
  }
}
