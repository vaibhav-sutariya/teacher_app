part of 'summary_bloc.dart';

abstract class SummaryState extends Equatable {
  const SummaryState();

  @override
  List<Object?> get props => [];
}

class SummaryInitial extends SummaryState {}

class SummaryLoading extends SummaryState {}

class SummaryLoaded extends SummaryState {
  final SummaryModel summary;
  final bool isRefreshing;

  const SummaryLoaded({required this.summary, this.isRefreshing = false});

  SummaryLoaded copyWith({SummaryModel? summary, bool? isRefreshing}) {
    return SummaryLoaded(
      summary: summary ?? this.summary,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  @override
  List<Object?> get props => [summary, isRefreshing];
}

class SummaryError extends SummaryState {
  final String message;

  const SummaryError(this.message);

  @override
  List<Object?> get props => [message];
}
