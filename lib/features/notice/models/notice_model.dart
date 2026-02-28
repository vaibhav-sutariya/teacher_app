import 'package:equatable/equatable.dart';

/// Notice model - ready for API integration
class NoticeModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String postedBy;
  final String? attachmentUrl;

  const NoticeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.postedBy,
    this.attachmentUrl,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    date,
    postedBy,
    attachmentUrl,
  ];

  /// Static mock data for development
  static List<NoticeModel> getMockData() {
    final now = DateTime.now();
    return [
      // Current month notices
      NoticeModel(
        id: '1',
        title: 'Annual Sports Meet 2024',
        description:
            'The annual sports meet for the academic year 2024 will be held on the last week of this month. All students are requested to participate.',
        date: DateTime(now.year, now.month, 10),
        postedBy: 'Admin Office',
      ),
      NoticeModel(
        id: '2',
        title: 'Parent-Teacher Meeting',
        description:
            'PTM for the second term will be conducted this Friday. Please ensure your presence to discuss your ward\'s progress.',
        date: DateTime(now.year, now.month, 12),
        postedBy: 'Principal',
      ),
      NoticeModel(
        id: '3',
        title: 'Holiday Notice: Independence Day',
        description:
            'The school will remain closed on 15th August on account of Independence Day. Flag hoisting ceremony starts at 8:00 AM.',
        date: DateTime(now.year, now.month, 15),
        postedBy: 'Principal',
      ),
      NoticeModel(
        id: '7',
        title: 'Library Book Return',
        description:
            'Students are reminded to return all overdue library books by the end of this week to avoid late fees.',
        date: DateTime(now.year, now.month, 18),
        postedBy: 'Librarian',
      ),
      NoticeModel(
        id: '8',
        title: 'School Fees Reminder',
        description:
            'This is a gentle reminder to settle the tuition fees for the third quarter. Please ignore if already paid.',
        date: DateTime(now.year, now.month, 20),
        postedBy: 'Accounts Dept',
      ),
      NoticeModel(
        id: '9',
        title: 'Drama Club Auditions',
        description:
            'Auditions for the upcoming theater production "The Brave Heart" will take place in the auditorium after school.',
        date: DateTime(now.year, now.month, 22),
        postedBy: 'Drama Club',
      ),

      // Previous month notices
      NoticeModel(
        id: '4',
        title: 'Final Exam Results',
        description:
            'Final examination results for the previous term have been declared. You can check them in the Report Card section.',
        date: DateTime(now.year, now.month - 1, 25),
        postedBy: 'Examination Dept',
      ),
      NoticeModel(
        id: '5',
        title: 'Summer Vacation Announcement',
        description:
            'Summer holidays will commence from next week. Homework assignments have been uploaded to the portal.',
        date: DateTime(now.year, now.month - 1, 5),
        postedBy: 'Admin Office',
      ),
      NoticeModel(
        id: '10',
        title: 'Internal Assessment Schedule',
        description:
            'The schedule for Internal Assessment-II has been posted on the notice board. Please review the dates carefully.',
        date: DateTime(now.year, now.month - 1, 15),
        postedBy: 'Principal',
      ),

      // Next month notices
      NoticeModel(
        id: '6',
        title: 'Science Fair Enrollment',
        description:
            'Enrollment for the upcoming Inter-school Science Fair is now open. Interested students can register at the lab.',
        date: DateTime(now.year, now.month + 1, 1),
        postedBy: 'Science Dept',
      ),
      NoticeModel(
        id: '11',
        title: 'Teacher Training Workshop',
        description:
            'The school will be closed for students next Monday due to a mandatory faculty development workshop.',
        date: DateTime(now.year, now.month + 1, 10),
        postedBy: 'Admin Office',
      ),
    ];
  }
}
