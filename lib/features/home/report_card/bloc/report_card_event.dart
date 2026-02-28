part of 'report_card_bloc.dart';

abstract class ReportCardEvent extends Equatable {
  const ReportCardEvent();

  @override
  List<Object> get props => [];
}

class LoadReportCards extends ReportCardEvent {
  final String? year;

  const LoadReportCards({this.year});

  @override
  List<Object> get props => [year ?? ''];
}

class ChangeAcademicYear extends ReportCardEvent {
  final String year;

  const ChangeAcademicYear(this.year);

  @override
  List<Object> get props => [year];
}
