part of 'birthday_bloc.dart';

enum BirthdayStatus { initial, loading, loaded, error }

class BirthdayState extends Equatable {
  final BirthdayStatus status;
  final List<BirthdayMemberModel> birthdays;
  final DateTime selectedDate;
  final DateTime focusedMonth;
  final String? errorMessage;

  const BirthdayState({
    this.status = BirthdayStatus.initial,
    this.birthdays = const [],
    required this.selectedDate,
    required this.focusedMonth,
    this.errorMessage,
  });

  factory BirthdayState.initial() {
    final now = DateTime.now();
    return BirthdayState(
      selectedDate: DateTime(now.year, now.month, now.day),
      focusedMonth: DateTime(now.year, now.month, 1),
    );
  }

  BirthdayState copyWith({
    BirthdayStatus? status,
    List<BirthdayMemberModel>? birthdays,
    DateTime? selectedDate,
    DateTime? focusedMonth,
    String? errorMessage,
  }) {
    return BirthdayState(
      status: status ?? this.status,
      birthdays: birthdays ?? this.birthdays,
      selectedDate: selectedDate ?? this.selectedDate,
      focusedMonth: focusedMonth ?? this.focusedMonth,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    birthdays,
    selectedDate,
    focusedMonth,
    errorMessage,
  ];

  /// Get birthdays for a specific day
  List<BirthdayMemberModel> getBirthdaysForDay(DateTime day) {
    return birthdays.where((b) {
      return b.dob.month == day.month && b.dob.day == day.day;
    }).toList();
  }

  /// Get student birthdays for the selected date
  List<BirthdayMemberModel> get selectedDateStudentBirthdays => birthdays.where((b) {
    return b.type == BirthdayType.student &&
        b.dob.month == selectedDate.month &&
        b.dob.day == selectedDate.day;
  }).toList();

  /// Get teacher birthdays for the selected date
  List<BirthdayMemberModel> get selectedDateTeacherBirthdays => birthdays.where((b) {
    return b.type == BirthdayType.teacher &&
        b.dob.month == selectedDate.month &&
        b.dob.day == selectedDate.day;
  }).toList();
}
