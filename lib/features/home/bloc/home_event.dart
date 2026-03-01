import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadEvents extends HomeEvent {}

class SelectDate extends HomeEvent {
  final DateTime date;
  const SelectDate(this.date);

  @override
  List<Object?> get props => [date];
}

class ChangeMonth extends HomeEvent {
  final DateTime month;
  const ChangeMonth(this.month);

  @override
  List<Object?> get props => [month];
}
