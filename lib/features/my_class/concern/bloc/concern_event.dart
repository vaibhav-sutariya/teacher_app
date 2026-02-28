part of 'concern_bloc.dart';

abstract class ConcernEvent extends Equatable {
  const ConcernEvent();

  @override
  List<Object> get props => [];
}

class LoadConcerns extends ConcernEvent {}

class FilterConcerns extends ConcernEvent {
  final int tabIndex;

  const FilterConcerns(this.tabIndex);

  @override
  List<Object> get props => [tabIndex];
}
