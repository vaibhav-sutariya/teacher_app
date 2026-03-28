import 'package:equatable/equatable.dart';

class TransportRouteModel extends Equatable {
  final String routeId;
  final String routeName;
  final String vehicleNumber;
  final int studentCount;
  final bool isMarked;

  const TransportRouteModel({
    required this.routeId,
    required this.routeName,
    required this.vehicleNumber,
    required this.studentCount,
    this.isMarked = false,
  });

  @override
  List<Object?> get props => [
    routeId,
    routeName,
    vehicleNumber,
    studentCount,
    isMarked,
  ];
}
