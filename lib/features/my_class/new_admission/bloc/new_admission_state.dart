part of 'new_admission_bloc.dart';

enum NewAdmissionStatus { initial, loading, loaded, error }

class NewAdmissionState extends Equatable {
  final NewAdmissionStatus status;
  final List<NewAdmissionModel> admissions;
  final DateTime selectedMonth;
  final int totalMonthAdmissions;
  final String? errorMessage;

  const NewAdmissionState({
    this.status = NewAdmissionStatus.initial,
    this.admissions = const [],
    required this.selectedMonth,
    this.totalMonthAdmissions = 0,
    this.errorMessage,
  });

  factory NewAdmissionState.initial() {
    final now = DateTime.now();
    return NewAdmissionState(
      selectedMonth: DateTime(now.year, now.month, 1),
    );
  }

  NewAdmissionState copyWith({
    NewAdmissionStatus? status,
    List<NewAdmissionModel>? admissions,
    DateTime? selectedMonth,
    int? totalMonthAdmissions,
    String? errorMessage,
  }) {
    return NewAdmissionState(
      status: status ?? this.status,
      admissions: admissions ?? this.admissions,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      totalMonthAdmissions: totalMonthAdmissions ?? this.totalMonthAdmissions,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    admissions,
    selectedMonth,
    totalMonthAdmissions,
    errorMessage,
  ];
}
