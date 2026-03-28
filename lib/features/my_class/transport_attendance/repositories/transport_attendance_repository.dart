import '../models/transport_student_model.dart';

class TransportAttendanceRepository {
  Future<List<TransportStudentModel>> getStudentsByRoute(String route) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return [
      const TransportStudentModel(
        id: '1',
        name: 'Aarush Kumar',
        rollNo: 'T-101',
        imageUrl: '',
      ),
      const TransportStudentModel(
        id: '2',
        name: 'Priya Sharma',
        rollNo: 'T-102',
        imageUrl: '',
      ),
      const TransportStudentModel(
        id: '3',
        name: 'Rohan Gupta',
        rollNo: 'T-103',
        imageUrl: '',
      ),
    ];
  }

  Future<bool> submitAttendance({
    required String route,
    required DateTime date,
    required List<TransportStudentModel> students,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    // Simulate success
    return true;
  }
}
