part of 'fees_bloc.dart';

enum FeesStatus { initial, loading, loaded, error }

class FeesState extends Equatable {
  final FeesStatus status;
  final DateTime selectedMonth;
  final FeesSummaryModel? summary;
  final List<FeesCollectionModel> collections;
  final String? errorMessage;

  const FeesState({
    this.status = FeesStatus.initial,
    required this.selectedMonth,
    this.summary,
    this.collections = const [],
    this.errorMessage,
  });

  FeesState copyWith({
    FeesStatus? status,
    DateTime? selectedMonth,
    FeesSummaryModel? summary,
    List<FeesCollectionModel>? collections,
    String? errorMessage,
  }) {
    return FeesState(
      status: status ?? this.status,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      summary: summary ?? this.summary,
      collections: collections ?? this.collections,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        selectedMonth,
        summary,
        collections,
        errorMessage,
      ];
}
