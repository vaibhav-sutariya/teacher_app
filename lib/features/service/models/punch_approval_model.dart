import 'package:equatable/equatable.dart';

enum PunchApprovalStatus { pending, approved, rejected }
enum PunchType { inPunch, outPunch }

class PunchApproval extends Equatable {
  final String id;
  final String name;
  final String date;
  final String time;
  final PunchType type;
  final PunchApprovalStatus status;
  final String? reason;

  const PunchApproval({
    required this.id,
    required this.name,
    required this.date,
    required this.time,
    required this.type,
    required this.status,
    this.reason,
  });

  @override
  List<Object?> get props => [id, name, date, time, type, status, reason];

  static List<PunchApproval> getMockData() {
    return [
      const PunchApproval(
        id: '1',
        name: 'John Doe',
        date: '25 Mar 2026',
        time: '09:15 AM',
        type: PunchType.inPunch,
        status: PunchApprovalStatus.pending,
        reason: 'Forgot to punch in',
      ),
      const PunchApproval(
        id: '2',
        name: 'Jane Smith',
        date: '24 Mar 2026',
        time: '06:30 PM',
        type: PunchType.outPunch,
        status: PunchApprovalStatus.pending,
        reason: 'Meeting ran late',
      ),
      const PunchApproval(
        id: '3',
        name: 'Robert Brown',
        date: '23 Mar 2026',
        time: '09:00 AM',
        type: PunchType.inPunch,
        status: PunchApprovalStatus.approved,
        reason: 'Machine error',
      ),
      const PunchApproval(
        id: '4',
        name: 'Alice Wilson',
        date: '22 Mar 2026',
        time: '06:00 PM',
        type: PunchType.outPunch,
        status: PunchApprovalStatus.rejected,
        reason: 'No valid reason provided',
      ),
    ];
  }
}
