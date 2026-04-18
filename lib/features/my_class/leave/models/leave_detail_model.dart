import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave_detail_model.freezed.dart';
part 'leave_detail_model.g.dart';

/// Activity type for leave request timeline
enum ActivityType {
  @JsonValue('approved')
  approved,
  @JsonValue('submitted')
  submitted,
  @JsonValue('rejected')
  rejected,
}

/// Activity log item for leave request timeline
@freezed
abstract class ActivityLogItem with _$ActivityLogItem {
  const factory ActivityLogItem({
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'subtitle') required String subtitle,
    @JsonKey(name: 'timestamp') required DateTime timestamp,
    @JsonKey(name: 'type') required ActivityType type,
  }) = _ActivityLogItem;

  factory ActivityLogItem.fromJson(Map<String, dynamic> json) =>
      _$ActivityLogItemFromJson(json);
}

/// Leave detail model containing all information about a leave request
@freezed
abstract class LeaveDetailModel with _$LeaveDetailModel {
  const factory LeaveDetailModel({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'status') required String status,
    @JsonKey(name: 'approvedBy') String? approvedBy,
    @JsonKey(name: 'startDate') required DateTime startDate,
    @JsonKey(name: 'endDate') required DateTime endDate,
    @JsonKey(name: 'days') required int days,
    @JsonKey(name: 'approvalDate') DateTime? approvalDate,
    @JsonKey(name: 'requestDate') required DateTime requestDate,
    @JsonKey(name: 'reason') required String reason,
    @JsonKey(name: 'activityLog') required List<ActivityLogItem> activityLog,
  }) = _LeaveDetailModel;

  factory LeaveDetailModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveDetailModelFromJson(json);

  /// Static mock data for development
  static LeaveDetailModel getMockData(String leaveId) {
    return LeaveDetailModel(
      id: leaveId,
      status: 'approved',
      approvedBy: 'Jigna Panchal',
      startDate: DateTime(2025, 11, 15),
      endDate: DateTime(2025, 11, 17),
      days: 3,
      approvalDate: DateTime(2025, 11, 17),
      requestDate: DateTime(2025, 11, 17, 8, 1),
      reason:
          'I am going to Surat for a wedding ceremony of my cousin. I will ensure all my pending assignments are submitted beforehand.',
      activityLog: [
        ActivityLogItem(
          title: 'Request Approved',
          subtitle: 'by Jigna Panchal • 17 Nov, 08:45 AM',
          timestamp: DateTime(2025, 11, 17, 8, 45),
          type: ActivityType.approved,
        ),
        ActivityLogItem(
          title: 'Request Submitted',
          subtitle: 'by Student • 17 Nov, 08:01 AM',
          timestamp: DateTime(2025, 11, 17, 8, 1),
          type: ActivityType.submitted,
        ),
      ],
    );
  }
}

/// Extension for helper methods
extension LeaveDetailModelExtension on LeaveDetailModel {
  /// Check if leave is approved
  bool get isApproved => status.toLowerCase() == 'approved';

  /// Check if leave is pending
  bool get isPending => status.toLowerCase() == 'pending';

  /// Check if leave is rejected
  bool get isRejected => status.toLowerCase() == 'rejected';

  /// Get status color
  int get statusColor {
    switch (status.toLowerCase()) {
      case 'approved':
        return 0xFF4CAF50;
      case 'pending':
        return 0xFFFFA726;
      case 'rejected':
        return 0xFFF44336;
      default:
        return 0xFF757575;
    }
  }
}
