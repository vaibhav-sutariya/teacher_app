import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/announcement_model.dart';

// Events
abstract class AnnouncementsEvent extends Equatable {
  const AnnouncementsEvent();
  @override
  List<Object?> get props => [];
}

class LoadAnnouncements extends AnnouncementsEvent {}

// State
abstract class AnnouncementsState extends Equatable {
  const AnnouncementsState();
  @override
  List<Object?> get props => [];
}

class AnnouncementsInitial extends AnnouncementsState {}

class AnnouncementsLoading extends AnnouncementsState {}

class AnnouncementsLoaded extends AnnouncementsState {
  final List<AnnouncementModel> announcements;
  const AnnouncementsLoaded(this.announcements);
  @override
  List<Object?> get props => [announcements];
}

class AnnouncementsError extends AnnouncementsState {
  final String message;
  const AnnouncementsError(this.message);
  @override
  List<Object?> get props => [message];
}

// Bloc
class AnnouncementsBloc extends Bloc<AnnouncementsEvent, AnnouncementsState> {
  AnnouncementsBloc() : super(AnnouncementsInitial()) {
    on<LoadAnnouncements>(_onLoadAnnouncements);
  }

  Future<void> _onLoadAnnouncements(
    LoadAnnouncements event,
    Emitter<AnnouncementsState> emit,
  ) async {
    emit(AnnouncementsLoading());
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      final data = AnnouncementModel.getMockData();
      emit(AnnouncementsLoaded(data));
    } catch (e) {
      emit(AnnouncementsError(e.toString()));
    }
  }
}
