part of 'birthday_bloc.dart';

abstract class BirthdayEvent extends Equatable {
  const BirthdayEvent();

  @override
  List<Object> get props => [];
}

class LoadBirthday extends BirthdayEvent {}
