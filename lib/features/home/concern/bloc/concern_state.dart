part of 'concern_bloc.dart';

abstract class ConcernState extends Equatable {
  const ConcernState();

  @override
  List<Object> get props => [];
}

class ConcernInitial extends ConcernState {}

class ConcernLoading extends ConcernState {}

class ConcernLoaded extends ConcernState {
  final List<ConcernModel> allConcerns;
  final List<ConcernModel> filteredConcerns;
  final int selectedTabIndex;

  const ConcernLoaded({
    required this.allConcerns,
    required this.filteredConcerns,
    this.selectedTabIndex = 0,
  });

  @override
  List<Object> get props => [allConcerns, filteredConcerns, selectedTabIndex];

  ConcernLoaded copyWith({
    List<ConcernModel>? allConcerns,
    List<ConcernModel>? filteredConcerns,
    int? selectedTabIndex,
  }) {
    return ConcernLoaded(
      allConcerns: allConcerns ?? this.allConcerns,
      filteredConcerns: filteredConcerns ?? this.filteredConcerns,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
    );
  }
}

class ConcernError extends ConcernState {
  final String message;

  const ConcernError(this.message);

  @override
  List<Object> get props => [message];
}
