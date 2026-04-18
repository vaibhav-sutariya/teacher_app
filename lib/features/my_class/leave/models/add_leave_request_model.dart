import 'leave_type_model.dart';

class AddLeaveRequestModel {
  final LeaveType leaveType;
  final DateTime fromDate;
  final DateTime toDate;
  final String reason;

  const AddLeaveRequestModel({
    required this.leaveType,
    required this.fromDate,
    required this.toDate,
    required this.reason,
  });

  Map<String, dynamic> toJson() {
    return {
      'leaveType': leaveType.toString(),
      'fromDate': fromDate.toIso8601String(),
      'toDate': toDate.toIso8601String(),
      'reason': reason,
    };
  }
}
