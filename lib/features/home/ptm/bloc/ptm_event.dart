import 'package:equatable/equatable.dart';

abstract class PtmEvent extends Equatable {
  const PtmEvent();

  @override
  List<Object?> get props => [];
}

class LoadPtms extends PtmEvent {}
