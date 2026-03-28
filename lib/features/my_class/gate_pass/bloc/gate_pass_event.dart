import 'package:equatable/equatable.dart';

abstract class GatePassEvent extends Equatable {
  const GatePassEvent();

  @override
  List<Object?> get props => [];
}

class LoadGatePasses extends GatePassEvent {}
