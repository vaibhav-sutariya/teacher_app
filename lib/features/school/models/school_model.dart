import 'package:equatable/equatable.dart';

class SchoolModel extends Equatable {
  final SchoolHeaderModel header;
  final String attendanceStatus;
  final List<AcademicPickModel> academicPicks;

  const SchoolModel({
    required this.header,
    required this.attendanceStatus,
    required this.academicPicks,
  });

  @override
  List<Object?> get props => [header, attendanceStatus, academicPicks];

  static SchoolModel getMockData() {
    return SchoolModel(
      header: SchoolHeaderModel.getDynamicHeader('DHARMA'),
      attendanceStatus: 'You are present today',
      academicPicks: const [
        AcademicPickModel(
          id: '1',
          title: "Today's Class work",
          subtitle: 'Notes given on chp-11.',
          type: AcademicPickType.classwork,
        ),
      ],
    );
  }
}

class SchoolHeaderModel extends Equatable {
  final String date;
  final String greeting;
  final String userName;

  const SchoolHeaderModel({
    required this.date,
    required this.greeting,
    required this.userName,
  });

  static SchoolHeaderModel getDynamicHeader(String userName) {
    final now = DateTime.now();
    final hour = now.hour;
    String greeting;

    if (hour < 12) {
      greeting = 'Good Morning';
    } else if (hour < 17) {
      greeting = 'Good Afternoon';
    } else if (hour < 19) {
      greeting = 'Good Evening';
    } else {
      greeting = 'Good Night';
    }

    // Format: 14-Feb-2026
    final day = now.day.toString().padLeft(2, '0');
    final year = now.year.toString();
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final month = months[now.month - 1];
    final formattedDate = '$day-$month-$year';

    return SchoolHeaderModel(
      date: formattedDate,
      greeting: greeting,
      userName: userName,
    );
  }

  @override
  List<Object?> get props => [date, greeting, userName];
}

enum AcademicPickType { classwork, homework, exam, event }

class AcademicPickModel extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final AcademicPickType type;

  const AcademicPickModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
  });

  @override
  List<Object?> get props => [id, title, subtitle, type];
}
