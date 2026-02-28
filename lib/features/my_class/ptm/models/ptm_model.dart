class PtmModel {
  final String id;
  final String title;
  final String date;
  final String time;
  final String description;
  final String teacherName;
  final String location;

  const PtmModel({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.description,
    required this.teacherName,
    required this.location,
  });

  static List<PtmModel> getMockData() {
    return const [
      PtmModel(
        id: '1',
        title: 'Mid-term Progress Review',
        date: '15 Oct, 2023',
        time: '10:00 AM - 10:30 AM',
        description:
            'Discussing the student\'s performance in the mid-term examinations and addressing any concerns.',
        teacherName: 'Mr. Michael Davis',
        location: 'Room 204, Main Building',
      ),
      PtmModel(
        id: '2',
        title: 'Annual Performance Meeting',
        date: '20 Dec, 2023',
        time: '11:15 AM - 11:45 AM',
        description:
            'Comprehensive review of the academic year, extracurricular participation, and overall development.',
        teacherName: 'Mrs. Sarah Connor',
        location: 'Conference Room B',
      ),
      PtmModel(
        id: '3',
        title: 'Special Parent Consultation',
        date: '05 Feb, 2024',
        time: '09:00 AM - 09:30 AM',
        description:
            'Special meeting to discuss recent behavioral improvements and set goals for the next term.',
        teacherName: 'Dr. Emily Chen',
        location: 'Principal\'s Office',
      ),
    ];
  }
}
