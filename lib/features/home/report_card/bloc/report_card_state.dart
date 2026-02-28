part of 'report_card_bloc.dart';

abstract class ReportCardState extends Equatable {
  const ReportCardState();

  @override
  List<Object> get props => [];
}

class ReportCardInitial extends ReportCardState {}

class ReportCardLoading extends ReportCardState {}

class ReportCardLoaded extends ReportCardState {
  final List<ReportCardModel> reportCards;
  final String selectedYear;
  final List<String> availableYears;

  const ReportCardLoaded({
    required this.reportCards,
    required this.selectedYear,
    this.availableYears = const ['2023 - 2024', '2024 - 2025'],
  });

  @override
  List<Object> get props => [reportCards, selectedYear, availableYears];

  ReportCardLoaded copyWith({
    List<ReportCardModel>? reportCards,
    String? selectedYear,
    List<String>? availableYears,
  }) {
    return ReportCardLoaded(
      reportCards: reportCards ?? this.reportCards,
      selectedYear: selectedYear ?? this.selectedYear,
      availableYears: availableYears ?? this.availableYears,
    );
  }
}

class ReportCardError extends ReportCardState {
  final String message;

  const ReportCardError(this.message);

  @override
  List<Object> get props => [message];
}
