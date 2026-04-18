part of 'bus_tracking_bloc.dart';

abstract class BusTrackingEvent extends Equatable {
  const BusTrackingEvent();

  @override
  List<Object?> get props => [];
}

class LoadBuses extends BusTrackingEvent {}

class RefreshBuses extends BusTrackingEvent {}
