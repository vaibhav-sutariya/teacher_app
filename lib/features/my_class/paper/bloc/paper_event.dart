part of 'paper_bloc.dart';

abstract class PaperEvent extends Equatable {
  const PaperEvent();

  @override
  List<Object> get props => [];
}

class PaperLoaded extends PaperEvent {}
