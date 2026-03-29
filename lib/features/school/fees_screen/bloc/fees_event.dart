part of 'fees_bloc.dart';

abstract class FeesEvent extends Equatable {
  const FeesEvent();

  @override
  List<Object?> get props => [];
}

class LoadFeesData extends FeesEvent {
  final DateTime month;
  const LoadFeesData(this.month);

  @override
  List<Object?> get props => [month];
}

class ChangeSelectedMonth extends FeesEvent {
  final DateTime month;
  const ChangeSelectedMonth(this.month);

  @override
  List<Object?> get props => [month];
}
