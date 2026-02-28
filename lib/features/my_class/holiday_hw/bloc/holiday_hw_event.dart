part of 'holiday_hw_bloc.dart';

abstract class HolidayHwEvent extends Equatable {
  const HolidayHwEvent();

  @override
  List<Object> get props => [];
}

class HolidayHwLoaded extends HolidayHwEvent {}
