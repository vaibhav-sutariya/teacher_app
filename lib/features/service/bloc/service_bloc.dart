import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/service_model.dart';

part 'service_event.dart';
part 'service_state.dart';

/// Bloc for managing Notice feature state
/// Handles month filtering and data loading with minimal rebuilds
class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final List<ServiceModel> _allNotices = ServiceModel.getMockData();

  ServiceBloc()
    : super(
        ServiceLoadedState(
          noticeList: const [],
          selectedMonth: DateTime(DateTime.now().year, DateTime.now().month, 1),
          isLoading: true,
        ),
      ) {
    on<LoadServiceData>(_onLoadServiceData);
    on<ServiceMonthChanged>(_onMonthChanged);
    on<RefreshServiceData>(_onRefreshServiceData);
  }

  /// Handle load notice data event
  Future<void> _onLoadServiceData(
    LoadServiceData event,
    Emitter<ServiceState> emit,
  ) async {
    if (state is ServiceLoadedState) {
      emit((state as ServiceLoadedState).copyWith(isLoading: true));
    }

    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 800));

      final currentMonth = state is ServiceLoadedState
          ? (state as ServiceLoadedState).selectedMonth
          : DateTime(DateTime.now().year, DateTime.now().month, 1);

      final filteredNotices = _filterNoticesByMonth(currentMonth);

      if (state is ServiceLoadedState) {
        emit(
          (state as ServiceLoadedState).copyWith(
            noticeList: filteredNotices,
            isLoading: false,
          ),
        );
      } else {
        emit(
          ServiceLoadedState(
            noticeList: filteredNotices,
            selectedMonth: currentMonth,
            isLoading: false,
          ),
        );
      }
    } catch (e) {
      emit(ServiceError(e.toString()));
    }
  }

  /// Handle month change event
  void _onMonthChanged(ServiceMonthChanged event, Emitter<ServiceState> emit) {
    if (state is ServiceLoadedState) {
      final currentState = state as ServiceLoadedState;

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
  Future<void> _onRefreshServiceData(
    RefreshServiceData event,
    Emitter<ServiceState> emit,
  ) async {
    if (state is ServiceLoadedState) {
      final currentState = state as ServiceLoadedState;
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
        emit(ServiceError(e.toString()));
      }
    }
  }

  /// Filter notices by month
  List<ServiceModel> _filterNoticesByMonth(DateTime month) {
    return _allNotices.where((notice) {
      return notice.date.year == month.year && notice.date.month == month.month;
    }).toList();
  }
}
