import 'package:equatable/equatable.dart';

enum StudentLeaveStatus { pending, approved, rejected }

class StudentLeaveModel extends Equatable {
  final String id;
  final String imageUrl;
  final String title;
  final String requestDate;
  final String className;
  final StudentLeaveStatus status;

  const StudentLeaveModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.requestDate,
    required this.className,
    required this.status,
  });

  @override
  List<Object?> get props => [
        id,
        imageUrl,
        title,
        requestDate,
        className,
        status,
      ];

  static List<StudentLeaveModel> getMockData() {
    return [
      // Pending
      const StudentLeaveModel(
        id: '1',
        imageUrl: 'https://i.pravatar.cc/150?img=1',
        title: 'OL | CHANPURA MISHREE JIGESH',
        requestDate: '09-Jun-2025 13:52',
        className: '6th-AAKASH',
        status: StudentLeaveStatus.pending,
      ),
      const StudentLeaveModel(
        id: '2',
        imageUrl: 'https://i.pravatar.cc/150?img=2',
        title: 'SF | DABHI VIHA SURAJSINH',
        requestDate: '11-Jun-2025 06:45',
        className: '6th-AAKASH',
        status: StudentLeaveStatus.pending,
      ),
      const StudentLeaveModel(
        id: '3',
        imageUrl: 'https://i.pravatar.cc/150?img=3',
        title: 'SF | ANSARI MO. NAVAJISH YUNUS',
        requestDate: '12-Jun-2025 09:39',
        className: '9th-JAL',
        status: StudentLeaveStatus.pending,
      ),
      const StudentLeaveModel(
        id: '4',
        imageUrl: 'https://i.pravatar.cc/150?img=4',
        title: 'SF | SOMVANSHI JAYNIL ANIL',
        requestDate: '12-Jun-2025 20:07',
        className: '10th-VAYU',
        status: StudentLeaveStatus.pending,
      ),
      const StudentLeaveModel(
        id: '5',
        imageUrl: 'https://i.pravatar.cc/150?img=5',
        title: 'SL | CHANPURA MISHREE JIGESH',
        requestDate: '13-Jun-2025 05:58',
        className: '6th-AAKASH',
        status: StudentLeaveStatus.pending,
      ),
      const StudentLeaveModel(
        id: '6',
        imageUrl: 'https://i.pravatar.cc/150?img=6',
        title: 'SF | SHAH YANA HARDIK',
        requestDate: '13-Jun-2025 14:46',
        className: '6th-AAKASH',
        status: StudentLeaveStatus.pending,
      ),
      const StudentLeaveModel(
        id: '7',
        imageUrl: 'https://i.pravatar.cc/150?img=7',
        title: 'SF | DESAI YAMI CHINTAN',
        requestDate: '13-Jun-2025 23:25',
        className: '6th-AAKASH',
        status: StudentLeaveStatus.pending,
      ),
      const StudentLeaveModel(
        id: '8',
        imageUrl: 'https://i.pravatar.cc/150?img=8',
        title: 'SL | DAVE AADITYA ABHIJIT',
        requestDate: '14-Jun-2025 06:28',
        className: '5th-JAL',
        status: StudentLeaveStatus.pending,
      ),
      // Approved
      const StudentLeaveModel(
        id: '9',
        imageUrl: 'https://i.pravatar.cc/150?img=9',
        title: 'SF | PATEL DHRUV RAMESH',
        requestDate: '01-Jun-2025 08:30',
        className: '8th-AGNI',
        status: StudentLeaveStatus.approved,
      ),
      const StudentLeaveModel(
        id: '10',
        imageUrl: 'https://i.pravatar.cc/150?img=10',
        title: 'OL | SHARMA PRIYA ANAND',
        requestDate: '02-Jun-2025 09:15',
        className: '7th-PRITHVI',
        status: StudentLeaveStatus.approved,
      ),
      // Rejected
      const StudentLeaveModel(
        id: '11',
        imageUrl: 'https://i.pravatar.cc/150?img=11',
        title: 'SF | SINGH RAHUL KUMAR',
        requestDate: '05-Jun-2025 11:20',
        className: '10th-VAYU',
        status: StudentLeaveStatus.rejected,
      ),
    ];
  }
}
