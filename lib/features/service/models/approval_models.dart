import 'package:equatable/equatable.dart';

enum ApprovalStatus { pending, approved, rejected }

enum ApprovalType { leave, gatePass, other }

class ApprovalItem extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String date;
  final ApprovalStatus status;
  final ApprovalType type;

  const ApprovalItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.status,
    required this.type,
  });

  @override
  List<Object?> get props => [id, title, subtitle, date, status, type];

  static List<ApprovalItem> getMockData() {
    return [
      const ApprovalItem(
        id: '1',
        title: 'John Doe',
        subtitle: 'Sick Leave Application',
        date: '25-Mar-2026',
        status: ApprovalStatus.pending,
        type: ApprovalType.leave,
      ),
      const ApprovalItem(
        id: '2',
        title: 'Jane Smith',
        subtitle: 'Casual Leave Application',
        date: '24-Mar-2026',
        status: ApprovalStatus.approved,
        type: ApprovalType.leave,
      ),
      const ApprovalItem(
        id: '3',
        title: 'Mike Ross',
        subtitle: 'Gate Pass Request',
        date: '23-Mar-2026',
        status: ApprovalStatus.rejected,
        type: ApprovalType.gatePass,
      ),
    ];
  }
}
