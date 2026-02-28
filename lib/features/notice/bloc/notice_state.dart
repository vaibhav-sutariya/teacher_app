part of 'notice_bloc.dart';

abstract class NoticeState extends Equatable {
  const NoticeState();

  @override
  List<Object?> get props => [];
}

class NoticeInitial extends NoticeState {}

class NoticeLoadedState extends NoticeState {
  final List<NoticeModel> noticeList;
  final DateTime selectedMonth;
  final bool isLoading;

  const NoticeLoadedState({
    required this.noticeList,
    required this.selectedMonth,
    this.isLoading = false,
  });

  NoticeLoadedState copyWith({
    List<NoticeModel>? noticeList,
    DateTime? selectedMonth,
    bool? isLoading,
  }) {
    return NoticeLoadedState(
      noticeList: noticeList ?? this.noticeList,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [noticeList, selectedMonth, isLoading];
}

class NoticeError extends NoticeState {
  final String message;

  const NoticeError(this.message);

  @override
  List<Object?> get props => [message];
}
