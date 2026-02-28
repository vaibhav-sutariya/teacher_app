import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/remark_model.dart';
import '../repositories/remark_repository.dart';
import 'remark_event.dart';
import 'remark_state.dart';

/// Production-ready remark bloc
/// Ready for API integration - currently uses mock data
class RemarkBloc extends Bloc<RemarkEvent, RemarkState> {
  final RemarkRepository _remarkRepository;

  RemarkBloc({RemarkRepository? remarkRepository})
    : _remarkRepository = remarkRepository ?? MockRemarkRepository(),
      super(RemarkState.initial()) {
    // Register event handlers
    on<LoadRemarksEvent>(_onLoadRemarks);
    on<RefreshRemarksEvent>(_onRefreshRemarks);
    on<LoadMoreRemarksEvent>(_onLoadMoreRemarks);
    on<ApplyFiltersEvent>(_onApplyFilters);
    on<ClearFiltersEvent>(_onClearFilters);

    // Load initial data
    add(const LoadRemarksEvent());
  }

  /// Handle load remarks event
  Future<void> _onLoadRemarks(
    LoadRemarksEvent event,
    Emitter<RemarkState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        clearError: true,
        currentPage: 1,
        hasMore: true,
      ),
    );

    try {
      final remarkData = await _remarkRepository.getRemarks(
        categories: state.selectedCategories,
        types: state.selectedTypes,
        page: 1,
        pageSize: state.pageSize,
      );
      final remarks = remarkData
          .map((json) => RemarkModel.fromJson(json))
          .toList();

      emit(
        state.copyWith(
          isLoading: false,
          remarks: remarks,
          currentPage: 1,
          hasMore: remarks.length >= state.pageSize,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to load remarks: ${e.toString()}',
        ),
      );
    }
  }

  /// Handle refresh remarks event
  Future<void> _onRefreshRemarks(
    RefreshRemarksEvent event,
    Emitter<RemarkState> emit,
  ) async {
    add(const LoadRemarksEvent());
  }

  /// Handle load more remarks event for pagination
  Future<void> _onLoadMoreRemarks(
    LoadMoreRemarksEvent event,
    Emitter<RemarkState> emit,
  ) async {
    // Don't load if already loading or no more data
    if (state.isLoadingMore || !state.hasMore) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true));

    try {
      final nextPage = state.currentPage + 1;
      final remarkData = await _remarkRepository.getRemarks(
        categories: state.selectedCategories,
        types: state.selectedTypes,
        page: nextPage,
        pageSize: state.pageSize,
      );
      final remarks = remarkData
          .map((json) => RemarkModel.fromJson(json))
          .toList();

      final updatedRemarks = [...state.remarks, ...remarks];

      emit(
        state.copyWith(
          isLoadingMore: false,
          remarks: updatedRemarks,
          currentPage: nextPage,
          hasMore: remarks.length >= state.pageSize,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingMore: false,
          errorMessage: 'Failed to load more remarks: ${e.toString()}',
        ),
      );
    }
  }

  /// Handle apply filters event
  Future<void> _onApplyFilters(
    ApplyFiltersEvent event,
    Emitter<RemarkState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedCategories: event.categories,
        selectedTypes: event.types,
        isLoading: true,
        clearError: true,
        currentPage: 1,
        hasMore: true,
      ),
    );

    try {
      final remarkData = await _remarkRepository.getRemarks(
        categories: event.categories,
        types: event.types,
        page: 1,
        pageSize: state.pageSize,
      );
      final remarks = remarkData
          .map((json) => RemarkModel.fromJson(json))
          .toList();

      emit(
        state.copyWith(
          isLoading: false,
          remarks: remarks,
          currentPage: 1,
          hasMore: remarks.length >= state.pageSize,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to filter remarks: ${e.toString()}',
        ),
      );
    }
  }

  /// Handle clear filters event
  Future<void> _onClearFilters(
    ClearFiltersEvent event,
    Emitter<RemarkState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedCategories: const [],
        selectedTypes: const [],
        isLoading: true,
        clearError: true,
        currentPage: 1,
        hasMore: true,
      ),
    );

    try {
      final remarkData = await _remarkRepository.getRemarks(
        page: 1,
        pageSize: state.pageSize,
      );
      final remarks = remarkData
          .map((json) => RemarkModel.fromJson(json))
          .toList();

      emit(
        state.copyWith(
          isLoading: false,
          remarks: remarks,
          currentPage: 1,
          hasMore: remarks.length >= state.pageSize,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to load remarks: ${e.toString()}',
        ),
      );
    }
  }
}
