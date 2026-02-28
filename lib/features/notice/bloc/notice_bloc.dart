import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/notice_model.dart';

part 'notice_event.dart';
part 'notice_state.dart';

/// Bloc for managing Notice feature state
/// Handles month filtering and data loading with minimal rebuilds
class NoticeBloc extends Bloc<NoticeEvent, NoticeState> {
  final List<NoticeModel> _allNotices = NoticeModel.getMockData();

  NoticeBloc()
    : super(
        NoticeLoadedState(
          noticeList: const [],
          selectedMonth: DateTime(DateTime.now().year, DateTime.now().month, 1),
          isLoading: true,
        ),
      ) {
    on<LoadNoticeData>(_onLoadNoticeData);
    on<NoticeMonthChanged>(_onMonthChanged);
    on<RefreshNoticeData>(_onRefreshNoticeData);
  }

  /// Handle load notice data event
  Future<void> _onLoadNoticeData(
    LoadNoticeData event,
    Emitter<NoticeState> emit,
  ) async {
    if (state is NoticeLoadedState) {
      emit((state as NoticeLoadedState).copyWith(isLoading: true));
    }

    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 800));

      final currentMonth = state is NoticeLoadedState
          ? (state as NoticeLoadedState).selectedMonth
          : DateTime(DateTime.now().year, DateTime.now().month, 1);

      final filteredNotices = _filterNoticesByMonth(currentMonth);

      if (state is NoticeLoadedState) {
        emit(
          (state as NoticeLoadedState).copyWith(
            noticeList: filteredNotices,
            isLoading: false,
          ),
        );
      } else {
        emit(
          NoticeLoadedState(
            noticeList: filteredNotices,
            selectedMonth: currentMonth,
            isLoading: false,
          ),
        );
      }
    } catch (e) {
      emit(NoticeError(e.toString()));
    }
  }

  /// Handle month change event
  void _onMonthChanged(NoticeMonthChanged event, Emitter<NoticeState> emit) {
    if (state is NoticeLoadedState) {
      final currentState = state as NoticeLoadedState;

      // Normalize month to first day
      final selectedMonth = DateTime(event.month.year, event.month.month, 1);

      // Filter data by selected month
      final filteredNotices = _filterNoticesByMonth(selectedMonth);

      emit(
        currentState.copyWith(
          selectedMonth: selectedMonth,
          noticeList: filteredNotices,
        ),
      );
    }
  }

  /// Handle refresh notice data event
  Future<void> _onRefreshNoticeData(
    RefreshNoticeData event,
    Emitter<NoticeState> emit,
  ) async {
    if (state is NoticeLoadedState) {
      final currentState = state as NoticeLoadedState;
      try {
        emit(currentState.copyWith(isLoading: true));
        // Simulate API delay
        await Future.delayed(const Duration(milliseconds: 500));

        final filteredNotices = _filterNoticesByMonth(
          currentState.selectedMonth,
        );

        emit(
          currentState.copyWith(noticeList: filteredNotices, isLoading: false),
        );
      } catch (e) {
        emit(NoticeError(e.toString()));
      }
    }
  }

  /// Filter notices by month
  List<NoticeModel> _filterNoticesByMonth(DateTime month) {
    return _allNotices.where((notice) {
      return notice.date.year == month.year && notice.date.month == month.month;
    }).toList();
  }
}
