import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/notification_model.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<LoadNotifications>(_onLoadNotifications);
  }

  Future<void> _onLoadNotifications(
    LoadNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoading());
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 600));

      final notifications = NotificationModel.getMockData();
      final grouped = NotificationModel.groupByDate(notifications);

      emit(NotificationLoaded(grouped));
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }
}
