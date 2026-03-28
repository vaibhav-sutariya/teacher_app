import '../models/transport_route_model.dart';

class ViewTransportAttendanceRepository {
  Future<List<TransportRouteModel>> getRoutesByDate(DateTime date) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Filter mocked data by date logically
    final isToday =
        date.day == DateTime.now().day && date.month == DateTime.now().month;
    if (isToday) {
      return const [
        TransportRouteModel(
          routeId: '1',
          routeName: 'Route A - City Center',
          vehicleNumber: 'KA-01-AB-1234',
          studentCount: 45,
          isMarked: true,
        ),
        TransportRouteModel(
          routeId: '2',
          routeName: 'Route B - West End',
          vehicleNumber: 'KA-01-CD-5678',
          studentCount: 32,
          isMarked: false,
        ),
        TransportRouteModel(
          routeId: '3',
          routeName: 'Route C - North Hills',
          vehicleNumber: 'KA-02-EF-9012',
          studentCount: 28,
          isMarked: false,
        ),
      ];
    } else {
      return const [
        TransportRouteModel(
          routeId: '1',
          routeName: 'Route A - City Center',
          vehicleNumber: 'KA-01-AB-1234',
          studentCount: 45,
          isMarked: true,
        ),
        TransportRouteModel(
          routeId: '2',
          routeName: 'Route B - West End',
          vehicleNumber: 'KA-01-CD-5678',
          studentCount: 32,
          isMarked: true,
        ),
        TransportRouteModel(
          routeId: '3',
          routeName: 'Route C - North Hills',
          vehicleNumber: 'KA-02-EF-9012',
          studentCount: 28,
          isMarked: true,
        ),
      ];
    }
  }
}
