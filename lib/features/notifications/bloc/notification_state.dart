import 'package:equatable/equatable.dart';
import '../models/notification_model.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object?> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final Map<String, List<NotificationModel>> groupedNotifications;

  const NotificationLoaded(this.groupedNotifications);

  @override
  List<Object?> get props => [groupedNotifications];
}

class NotificationError extends NotificationState {
  final String message;

  const NotificationError(this.message);

  @override
  List<Object?> get props => [message];
}
