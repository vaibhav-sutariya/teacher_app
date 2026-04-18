part of 'staff_notice_bloc.dart';

abstract class StaffNoticeEvent extends Equatable {
  const StaffNoticeEvent();

  @override
  List<Object?> get props => [];
}

class LoadStaffNotices extends StaffNoticeEvent {}
