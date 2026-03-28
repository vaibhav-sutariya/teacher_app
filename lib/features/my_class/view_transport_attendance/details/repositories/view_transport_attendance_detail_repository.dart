import '../../../transport_attendance/models/transport_student_model.dart';
import '../../models/transport_route_model.dart';

class ViewTransportAttendanceDetailRepository {
  Future<List<TransportStudentModel>> getStudentsByRouteAndDate(
    TransportRouteModel route,
    DateTime date,
  ) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Generate some mock data using the TransportStudentModel from the marking feature
    // We will simulate that if the route is marked, we return a mix of boarded and absent students
    final random = DateTime.now().millisecondsSinceEpoch;

    List<TransportStudentModel> students = List.generate(route.studentCount, (
      index,
    ) {
      final isBoarded = route.isMarked
          ? (index % 5 != 0)
          : false; // If marked, 80% boarded
      final isAbsent = route.isMarked && !isBoarded;

      return TransportStudentModel(
        id: 'student_$index',
        name: 'Student Name ${index + 1}',
        rollNo: '2023-${1000 + index}',
        imageUrl: 'https://i.pravatar.cc/150?u=${route.routeId}_$index',
        status: route.isMarked
            ? (isBoarded
                  ? TransportAttendanceStatus.boarded
                  : TransportAttendanceStatus.notBoarded)
            : TransportAttendanceStatus.notMarked,
      );
    });

    return students;
  }
}
