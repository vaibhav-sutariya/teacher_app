part of 'add_staff_notice_bloc.dart';

enum AddStaffNoticeStatus { initial, submitting, success, error }

class AddStaffNoticeState extends Equatable {
  final String title;
  final String content;
  final DateTime date;
  final AddStaffNoticeStatus status;
  final String? error;

  AddStaffNoticeState({
    this.title = '',
    this.content = '',
    DateTime? date,
    this.status = AddStaffNoticeStatus.initial,
    this.error,
  }) : date = date ?? (DateTime.now());

  AddStaffNoticeState copyWith({
    String? title,
    String? content,
    DateTime? date,
    AddStaffNoticeStatus? status,
    String? error,
  }) {
    return AddStaffNoticeState(
      title: title ?? this.title,
      content: content ?? this.content,
      date: date ?? this.date,
      status: status ?? this.status,
      error: error,
    );
  }

  @override
  List<Object?> get props => [title, content, date, status, error];
}
