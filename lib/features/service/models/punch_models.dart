import 'package:equatable/equatable.dart';

enum PunchType { inPunch, outPunch }

class PunchRecord extends Equatable {
  final String id;
  final String date;
  final String time;
  final PunchType type;
  final String status;
  final String? reason;

  const PunchRecord({
    required this.id,
    required this.date,
    required this.time,
    required this.type,
    required this.status,
    this.reason,
  });

  @override
  List<Object?> get props => [id, date, time, type, status, reason];

  static List<PunchRecord> getMockData(DateTime month) {
    return [
      PunchRecord(
        id: '1',
        date: '25 Mar 2026',
        time: '09:30 AM',
        type: PunchType.inPunch,
        status: 'Approved',
        reason: 'Forgot to punch in',
      ),
      const PunchRecord(
        id: '2',
        date: '24 Mar 2026',
        time: '06:15 PM',
        type: PunchType.outPunch,
        status: 'Approved',
        reason: 'Late exit due to meeting',
      ),
      const PunchRecord(
        id: '3',
        date: '23 Mar 2026',
        time: '09:05 AM',
        type: PunchType.inPunch,
        status: 'Pending',
        reason: 'Machine was not working',
      ),
      const PunchRecord(
        id: '4',
        date: '22 Mar 2026',
        time: '06:00 PM',
        type: PunchType.outPunch,
        status: 'Approved',
      ),
    ];
  }
}
