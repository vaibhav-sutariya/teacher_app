part of 'admission_details_bloc.dart';

enum AdmissionDetailsStatus { initial, loading, loaded, error }

class AdmissionDetailsState extends Equatable {
  final AdmissionDetailsStatus status;
  final List<AdmissionClassModel> classAdmissions;
  final int totalCount;
  final DateTime? selectedDate;
  final String? errorMessage;

  const AdmissionDetailsState({
    this.status = AdmissionDetailsStatus.initial,
    this.classAdmissions = const [],
    this.totalCount = 0,
    this.selectedDate,
    this.errorMessage,
  });

  AdmissionDetailsState copyWith({
    AdmissionDetailsStatus? status,
    List<AdmissionClassModel>? classAdmissions,
    int? totalCount,
    DateTime? selectedDate,
    String? errorMessage,
  }) {
    return AdmissionDetailsState(
      status: status ?? this.status,
      classAdmissions: classAdmissions ?? this.classAdmissions,
      totalCount: totalCount ?? this.totalCount,
      selectedDate: selectedDate ?? this.selectedDate,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        classAdmissions,
        totalCount,
        selectedDate,
        errorMessage,
      ];
}
