import 'package:equatable/equatable.dart';

enum BusStatus { running, stopped, delayed }

class BusModel extends Equatable {
  final String id;
  final String busNumber;
  final String routeName;
  final BusStatus status;
  final String driverName;
  final String driverPhone;
  final String speed;
  final String lastLocation;
  final DateTime lastUpdated;

  const BusModel({
    required this.id,
    required this.busNumber,
    required this.routeName,
    required this.status,
    required this.driverName,
    required this.driverPhone,
    required this.speed,
    required this.lastLocation,
    required this.lastUpdated,
  });

  @override
  List<Object?> get props => [
        id,
        busNumber,
        routeName,
        status,
        driverName,
        driverPhone,
        speed,
        lastLocation,
        lastUpdated,
      ];
}
