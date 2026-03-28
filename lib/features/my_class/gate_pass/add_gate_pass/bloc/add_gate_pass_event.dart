import 'package:equatable/equatable.dart';
import '../../models/gate_pass_model.dart';

abstract class AddGatePassEvent extends Equatable {
  const AddGatePassEvent();

  @override
  List<Object?> get props => [];
}

class SelectClassEvent extends AddGatePassEvent {
  final String className;
  const SelectClassEvent(this.className);

  @override
  List<Object?> get props => [className];
}

class SelectSectionEvent extends AddGatePassEvent {
  final String section;
  const SelectSectionEvent(this.section);

  @override
  List<Object?> get props => [section];
}

class SelectDateEvent extends AddGatePassEvent {
  final DateTime date;
  const SelectDateEvent(this.date);

  @override
  List<Object?> get props => [date];
}

class SelectTimeEvent extends AddGatePassEvent {
  final String time;
  const SelectTimeEvent(this.time);

  @override
  List<Object?> get props => [time];
}

class SelectPickupTypeEvent extends AddGatePassEvent {
  final GatePassType type;
  const SelectPickupTypeEvent(this.type);

  @override
  List<Object?> get props => [type];
}

class UpdateReasonEvent extends AddGatePassEvent {
  final String reason;
  const UpdateReasonEvent(this.reason);

  @override
  List<Object?> get props => [reason];
}

class LoadStudentsEvent extends AddGatePassEvent {}

class SearchStudentsEvent extends AddGatePassEvent {
  final String query;
  const SearchStudentsEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class SelectStudentEvent extends AddGatePassEvent {
  final String studentId;
  const SelectStudentEvent(this.studentId);

  @override
  List<Object?> get props => [studentId];
}

class SubmitGatePassEvent extends AddGatePassEvent {}
