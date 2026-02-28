part of 'notice_bloc.dart';

abstract class NoticeEvent extends Equatable {
  const NoticeEvent();

  @override
  List<Object?> get props => [];
}

class LoadNoticeData extends NoticeEvent {}

class NoticeMonthChanged extends NoticeEvent {
  final DateTime month;

  const NoticeMonthChanged(this.month);

  @override
  List<Object?> get props => [month];
}

class RefreshNoticeData extends NoticeEvent {}
