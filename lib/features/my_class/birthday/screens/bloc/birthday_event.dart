part of 'birthday_bloc.dart';

abstract class BirthdayEvent extends Equatable {
  const BirthdayEvent();

  @override
  List<Object?> get props => [];
}

class LoadMonthBirthdays extends BirthdayEvent {
  final DateTime month;
  const LoadMonthBirthdays(this.month);

  @override
  List<Object?> get props => [month];
}

class SelectBirthdayDate extends BirthdayEvent {
  final DateTime date;
  const SelectBirthdayDate(this.date);

  @override
  List<Object?> get props => [date];
}

class ChangeBirthdayMonth extends BirthdayEvent {
  final DateTime month;
  const ChangeBirthdayMonth(this.month);

  @override
  List<Object?> get props => [month];
}
