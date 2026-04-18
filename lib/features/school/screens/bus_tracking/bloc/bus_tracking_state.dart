part of 'bus_tracking_bloc.dart';

abstract class BusTrackingState extends Equatable {
  const BusTrackingState();

  @override
  List<Object?> get props => [];
}

class BusTrackingInitial extends BusTrackingState {}

class BusTrackingLoading extends BusTrackingState {}

class BusTrackingLoaded extends BusTrackingState {
  final List<BusModel> buses;
  const BusTrackingLoaded({required this.buses});

  @override
  List<Object?> get props => [buses];
}

class BusTrackingError extends BusTrackingState {
  final String message;
  const BusTrackingError({required this.message});

  @override
  List<Object?> get props => [message];
}
