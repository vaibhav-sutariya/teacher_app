import 'package:equatable/equatable.dart';
import '../models/achievement_model.dart';

abstract class AchievementState extends Equatable {
  const AchievementState();

  @override
  List<Object?> get props => [];
}

class AchievementInitial extends AchievementState {}

class AchievementLoading extends AchievementState {}

class AchievementLoaded extends AchievementState {
  final List<AchievementModel> achievements;

  const AchievementLoaded({required this.achievements});

  @override
  List<Object?> get props => [achievements];
}

class AchievementError extends AchievementState {
  final String message;

  const AchievementError(this.message);

  @override
  List<Object?> get props => [message];
}
