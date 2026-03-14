import '../models/ptm_model.dart';

abstract class PtmRepository {
  Future<List<PtmModel>> getPtmList();
  Future<void> createPtm({
    required String title,
    required String date,
    required String time,
    required String location,
    required String description,
  });
}

class MockPtmRepository implements PtmRepository {
  static List<PtmModel> _allPtms = [
    const PtmModel(
      id: '1',
      title: 'Mid-term Progress Review',
      date: '15 Oct, 2023',
      time: '10:00 AM - 10:30 AM',
      description:
          'Discussing the student\'s performance in the mid-term examinations and addressing any concerns.',
      teacherName: 'Mr. Michael Davis',
      location: 'Room 204, Main Building',
    ),
    const PtmModel(
      id: '2',
      title: 'Annual Performance Meeting',
      date: '20 Dec, 2023',
      time: '11:15 AM - 11:45 AM',
      description:
          'Comprehensive review of the academic year, extracurricular participation, and overall development.',
      teacherName: 'Mrs. Sarah Connor',
      location: 'Conference Room B',
    ),
  ];

  @override
  Future<List<PtmModel>> getPtmList() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return _allPtms;
  }

  @override
  Future<void> createPtm({
    required String title,
    required String date,
    required String time,
    required String location,
    required String description,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    final newPtm = PtmModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      date: date,
      time: time,
      location: location,
      description: description,
      teacherName: 'Mr. Michael Davis', // Mock current teacher
    );

    _allPtms.insert(0, newPtm);
  }
}
