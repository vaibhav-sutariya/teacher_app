part of 'add_staff_notice_bloc.dart';

abstract class AddStaffNoticeEvent extends Equatable {
  const AddStaffNoticeEvent();

  @override
  List<Object?> get props => [];
}

class UpdateStaffNoticeTitle extends AddStaffNoticeEvent {
  final String title;
  const UpdateStaffNoticeTitle(this.title);

  @override
  List<Object?> get props => [title];
}

class UpdateStaffNoticeContent extends AddStaffNoticeEvent {
  final String content;
  const UpdateStaffNoticeContent(this.content);

  @override
  List<Object?> get props => [content];
}

class UpdateStaffNoticeDate extends AddStaffNoticeEvent {
  final DateTime date;
  const UpdateStaffNoticeDate(this.date);

  @override
  List<Object?> get props => [date];
}

class SubmitStaffNotice extends AddStaffNoticeEvent {}
