part of 'staff_notice_bloc.dart';

abstract class StaffNoticeState extends Equatable {
  const StaffNoticeState();

  @override
  List<Object?> get props => [];
}

class StaffNoticeInitial extends StaffNoticeState {}

class StaffNoticeLoading extends StaffNoticeState {}

class StaffNoticeLoaded extends StaffNoticeState {
  final List<StaffNoticeModel> notices;

  const StaffNoticeLoaded({required this.notices});

  @override
  List<Object?> get props => [notices];
}

class StaffNoticeError extends StaffNoticeState {
  final String message;

  const StaffNoticeError({required this.message});

  @override
  List<Object?> get props => [message];
}
