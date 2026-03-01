part of 'service_bloc.dart';

abstract class ServiceEvent extends Equatable {
  const ServiceEvent();

  @override
  List<Object?> get props => [];
}

class LoadServiceData extends ServiceEvent {}

class ServiceMonthChanged extends ServiceEvent {
  final DateTime month;

  const ServiceMonthChanged(this.month);

  @override
  List<Object?> get props => [month];
}

class RefreshServiceData extends ServiceEvent {}
