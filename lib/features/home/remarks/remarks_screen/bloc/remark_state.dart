import 'package:equatable/equatable.dart';

import '../models/remark_model.dart';

/// Remark state with pagination and multiple filter selections support
class RemarkState extends Equatable {
  final List<RemarkModel> remarks;
  final bool isLoading;
  final bool isLoadingMore;
  final String? errorMessage;
  final List<RemarkCategory> selectedCategories;
  final List<RemarkType> selectedTypes;
  final bool hasActiveFilters;
  final int currentPage;
  final bool hasMore;
  final int pageSize;

  const RemarkState({
    required this.remarks,
    required this.isLoading,
    this.isLoadingMore = false,
    this.errorMessage,
    this.selectedCategories = const [],
    this.selectedTypes = const [],
    this.hasActiveFilters = false,
    this.currentPage = 1,
    this.hasMore = true,
    this.pageSize = 10, // Load 10 items per page
  });

  factory RemarkState.initial() {
    return const RemarkState(
      remarks: [],
      isLoading: false,
      isLoadingMore: false,
      errorMessage: null,
      selectedCategories: [],
      selectedTypes: [],
      hasActiveFilters: false,
      currentPage: 1,
      hasMore: true,
      pageSize: 10,
    );
  }

  RemarkState copyWith({
    List<RemarkModel>? remarks,
    bool? isLoading,
    bool? isLoadingMore,
    String? errorMessage,
    List<RemarkCategory>? selectedCategories,
    List<RemarkType>? selectedTypes,
    bool? hasActiveFilters,
    int? currentPage,
    bool? hasMore,
    int? pageSize,
    bool clearError = false,
  }) {
    final newCategories = selectedCategories ?? this.selectedCategories;
    final newTypes = selectedTypes ?? this.selectedTypes;

    return RemarkState(
      remarks: remarks ?? this.remarks,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      selectedCategories: newCategories,
      selectedTypes: newTypes,
      hasActiveFilters:
          hasActiveFilters ?? (newCategories.isNotEmpty || newTypes.isNotEmpty),
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  @override
  List<Object?> get props => [
    remarks,
    isLoading,
    isLoadingMore,
    errorMessage,
    selectedCategories,
    selectedTypes,
    hasActiveFilters,
    currentPage,
    hasMore,
    pageSize,
  ];
}
