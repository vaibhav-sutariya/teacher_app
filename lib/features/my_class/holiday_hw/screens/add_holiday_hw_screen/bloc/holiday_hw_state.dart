part of 'holiday_hw_bloc.dart';

abstract class HolidayHwState extends Equatable {
  const HolidayHwState();

  @override
  List<Object> get props => [];
}

class HolidayHwInitial extends HolidayHwState {}

class HolidayHwLoading extends HolidayHwState {}

class HolidayHwLoadedState extends HolidayHwState {
  final List<HolidayHwModel> hwList;

  const HolidayHwLoadedState(this.hwList);

  @override
  List<Object> get props => [hwList];
}

class HolidayHwError extends HolidayHwState {
  final String message;

  const HolidayHwError(this.message);

  @override
  List<Object> get props => [message];
}
