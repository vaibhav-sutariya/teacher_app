part of 'holiday_hw_bloc.dart';

abstract class HolidayHwState extends Equatable {
  const HolidayHwState();

  @override
  List<Object> get props => [];
}

class HolidayHwLoading extends HolidayHwState {}

class HolidayHwLoadedState extends HolidayHwState {
  final List<HolidayHwModel> holidayHwList;

  const HolidayHwLoadedState(this.holidayHwList);

  @override
  List<Object> get props => [holidayHwList];
}

class HolidayHwError extends HolidayHwState {
  final String message;

  const HolidayHwError(this.message);

  @override
  List<Object> get props => [message];
}
