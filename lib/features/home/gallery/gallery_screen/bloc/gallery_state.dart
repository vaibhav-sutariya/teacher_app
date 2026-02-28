import 'package:equatable/equatable.dart';

import '../models/gallery_model.dart';

/// Gallery state with pagination support
class GalleryState extends Equatable {
  final bool isLoading;
  final bool isLoadingMore;
  final List<GalleryModel> galleryList;
  final String? errorMessage;
  final int currentPage;
  final bool hasMore;
  final int pageSize;

  const GalleryState({
    this.isLoading = false,
    this.isLoadingMore = false,
    this.galleryList = const [],
    this.errorMessage,
    this.currentPage = 1,
    this.hasMore = true,
    this.pageSize = 6, // Load 6 items per page (2 columns x 3 rows)
  });

  GalleryState copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    List<GalleryModel>? galleryList,
    String? errorMessage,
    int? currentPage,
    bool? hasMore,
    int? pageSize,
    bool clearError = false,
  }) {
    return GalleryState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      galleryList: galleryList ?? this.galleryList,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isLoadingMore,
    galleryList,
    errorMessage,
    currentPage,
    hasMore,
    pageSize,
  ];
}
