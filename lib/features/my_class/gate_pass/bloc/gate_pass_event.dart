import 'package:equatable/equatable.dart';

abstract class GatePassEvent extends Equatable {
  const GatePassEvent();

  @override
  List<Object?> get props => [];
}

class LoadGatePasses extends GatePassEvent {}

class SwitchTab extends GatePassEvent {
  final int index;
  const SwitchTab(this.index);

  @override
  List<Object?> get props => [index];
}
