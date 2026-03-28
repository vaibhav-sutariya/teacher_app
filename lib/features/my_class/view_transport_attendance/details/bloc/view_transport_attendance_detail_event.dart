import 'package:equatable/equatable.dart';
import '../../models/transport_route_model.dart';

abstract class ViewTransportAttendanceDetailEvent extends Equatable {
  const ViewTransportAttendanceDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadTransportDetailsEvent extends ViewTransportAttendanceDetailEvent {
  final TransportRouteModel route;
  final DateTime date;

  const LoadTransportDetailsEvent({required this.route, required this.date});

  @override
  List<Object> get props => [route, date];
}
