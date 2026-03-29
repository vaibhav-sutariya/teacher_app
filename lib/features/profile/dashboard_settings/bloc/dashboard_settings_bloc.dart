import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/dashboard_setting_item.dart';

// --- Events ---
abstract class DashboardSettingsEvent extends Equatable {
  const DashboardSettingsEvent();
  @override
  List<Object?> get props => [];
}

class LoadDashboardSettings extends DashboardSettingsEvent {}

class ToggleDashboardSetting extends DashboardSettingsEvent {
  final String settingId;
  const ToggleDashboardSetting(this.settingId);
  @override
  List<Object?> get props => [settingId];
}

// --- States ---
abstract class DashboardSettingsState extends Equatable {
  const DashboardSettingsState();
  @override
  List<Object?> get props => [];
}

class DashboardSettingsInitial extends DashboardSettingsState {}

class DashboardSettingsLoading extends DashboardSettingsState {}

class DashboardSettingsLoaded extends DashboardSettingsState {
  final List<DashboardSettingItem> settings;

  const DashboardSettingsLoaded({required this.settings});

  DashboardSettingsLoaded copyWith({
    List<DashboardSettingItem>? settings,
  }) {
    return DashboardSettingsLoaded(
      settings: settings ?? this.settings,
    );
  }

  @override
  List<Object?> get props => [settings];
}

class DashboardSettingsError extends DashboardSettingsState {
  final String message;
  const DashboardSettingsError(this.message);
  @override
  List<Object?> get props => [message];
}

// --- Bloc ---
class DashboardSettingsBloc extends Bloc<DashboardSettingsEvent, DashboardSettingsState> {
  DashboardSettingsBloc() : super(DashboardSettingsInitial()) {
    on<LoadDashboardSettings>(_onLoadSettings);
    on<ToggleDashboardSetting>(_onToggleSetting);
  }

  Future<void> _onLoadSettings(
    LoadDashboardSettings event,
    Emitter<DashboardSettingsState> emit,
  ) async {
    emit(DashboardSettingsLoading());
    try {
      // Simulate fetch delay
      await Future.delayed(const Duration(milliseconds: 300));
      emit(DashboardSettingsLoaded(
        settings: DashboardSettingItem.getDefaultSettings(),
      ));
    } catch (e) {
      emit(DashboardSettingsError(e.toString()));
    }
  }

  void _onToggleSetting(
    ToggleDashboardSetting event,
    Emitter<DashboardSettingsState> emit,
  ) {
    if (state is DashboardSettingsLoaded) {
      final currentState = state as DashboardSettingsLoaded;
      final updatedSettings = currentState.settings.map((item) {
        if (item.id == event.settingId) {
          return item.copyWith(isEnabled: !item.isEnabled);
        }
        return item;
      }).toList();

      emit(currentState.copyWith(settings: updatedSettings));
      
      // Note: In a real app, you would also trigger a repository call here
      // to save these preferences to SharedPreferences or an API.
    }
  }
}
