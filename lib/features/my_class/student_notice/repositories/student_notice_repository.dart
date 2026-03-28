import '../models/student_notice_model.dart';

class StudentNoticeRepository {
  // Mock API call to get student notices
  Future<List<StudentNoticeModel>> getNotices() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return [
      StudentNoticeModel(
        id: '1',
        title: 'Holiday Notice',
        content: 'School will be closed tomorrow due to heavy rain.',
        date: DateTime.now().subtract(const Duration(days: 1)),
        className: 'Class 5',
      ),
      StudentNoticeModel(
        id: '2',
        title: 'Exam Schedule',
        content: 'Final exams will begin from 15th of next month.',
        date: DateTime.now().subtract(const Duration(days: 2)),
        className: 'Class 8',
      ),
    ];
  }

  // Mock API call to submit a student notice
  Future<bool> submitNotice({
    required String classId,
    required String sectionId,
    required DateTime date,
    required String title,
    required String content,
    required List<String> studentIds,
    String? imagePath,
    String? docPath,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    // Simulate successful submission
    return true;
  }
}
