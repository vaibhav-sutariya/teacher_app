part of 'school_bloc.dart';

abstract class SchoolState extends Equatable {
  const SchoolState();

  @override
  List<Object?> get props => [];
}

class SchoolInitial extends SchoolState {}

class SchoolLoading extends SchoolState {}

class SchoolLoaded extends SchoolState {
  final SchoolModel summary;
  final bool isRefreshing;

  const SchoolLoaded({required this.summary, this.isRefreshing = false});

  SchoolLoaded copyWith({SchoolModel? summary, bool? isRefreshing}) {
    return SchoolLoaded(
      summary: summary ?? this.summary,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  @override
  List<Object?> get props => [summary, isRefreshing];
}

class SchoolError extends SchoolState {
  final String message;

  const SchoolError(this.message);

  @override
  List<Object?> get props => [message];
}
