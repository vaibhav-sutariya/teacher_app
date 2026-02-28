import 'package:equatable/equatable.dart';
import '../models/ptm_model.dart';

abstract class PtmState extends Equatable {
  const PtmState();

  @override
  List<Object?> get props => [];
}

class PtmInitial extends PtmState {}

class PtmLoading extends PtmState {}

class PtmLoaded extends PtmState {
  final List<PtmModel> ptms;

  const PtmLoaded({required this.ptms});

  @override
  List<Object?> get props => [ptms];
}

class PtmError extends PtmState {
  final String message;

  const PtmError(this.message);

  @override
  List<Object?> get props => [message];
}
