part of 'paper_bloc.dart';

abstract class PaperState extends Equatable {
  const PaperState();

  @override
  List<Object> get props => [];
}

class PaperInitial extends PaperState {}

class PaperLoading extends PaperState {}

class PaperLoadedState extends PaperState {
  final List<PaperModel> paperList;

  const PaperLoadedState(this.paperList);

  @override
  List<Object> get props => [paperList];
}

class PaperError extends PaperState {
  final String message;

  const PaperError(this.message);

  @override
  List<Object> get props => [message];
}
