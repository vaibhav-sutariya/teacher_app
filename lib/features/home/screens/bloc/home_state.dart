import 'package:equatable/equatable.dart';
import '../../models/dashboard_models.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final String? errorMessage;

  // Dashboard properties
  final List<EventModel> todayEvents;
  final List<AnnouncementModel> announcements;
  final List<LeaveModel> pendingLeaves;
  final List<BirthdayModel> birthdays;
  final HomeworkStatsModel homeworkStats;
  final AttendanceStatsModel attendanceStats;
  final bool isCheckedIn;

  const HomeState({
    this.status = HomeStatus.initial,
    this.errorMessage,
    this.todayEvents = const [],
    this.announcements = const [],
    this.pendingLeaves = const [],
    this.birthdays = const [],
    this.homeworkStats = const HomeworkStatsModel(
      updatedSections: 0,
      totalSections: 0,
    ),
    this.attendanceStats = const AttendanceStatsModel(
      markedSections: 0,
      totalSections: 0,
    ),
    this.isCheckedIn = false,
  });

  factory HomeState.initial() {
    return const HomeState();
  }

  HomeState copyWith({
    HomeStatus? status,
    String? errorMessage,
    List<EventModel>? todayEvents,
    List<AnnouncementModel>? announcements,
    List<LeaveModel>? pendingLeaves,
    List<BirthdayModel>? birthdays,
    HomeworkStatsModel? homeworkStats,
    AttendanceStatsModel? attendanceStats,
    bool? isCheckedIn,
  }) {
    return HomeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      todayEvents: todayEvents ?? this.todayEvents,
      announcements: announcements ?? this.announcements,
      pendingLeaves: pendingLeaves ?? this.pendingLeaves,
      birthdays: birthdays ?? this.birthdays,
      homeworkStats: homeworkStats ?? this.homeworkStats,
      attendanceStats: attendanceStats ?? this.attendanceStats,
      isCheckedIn: isCheckedIn ?? this.isCheckedIn,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    todayEvents,
    announcements,
    pendingLeaves,
    birthdays,
    homeworkStats,
    attendanceStats,
    isCheckedIn,
  ];
}
