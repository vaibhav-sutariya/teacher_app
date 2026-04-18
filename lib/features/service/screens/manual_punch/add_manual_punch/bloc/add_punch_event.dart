part of 'add_punch_bloc.dart';

abstract class AddPunchEvent extends Equatable {
  const AddPunchEvent();

  @override
  List<Object?> get props => [];
}

class SubmitPunch extends AddPunchEvent {
  final DateTime date;
  final String type;
  final String time;
  final String reason;

  const SubmitPunch({
    required this.date,
    required this.type,
    required this.time,
    required this.reason,
  });

  @override
  List<Object?> get props => [date, type, time, reason];
}
