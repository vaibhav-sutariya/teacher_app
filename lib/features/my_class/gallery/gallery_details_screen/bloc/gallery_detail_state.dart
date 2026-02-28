import 'package:equatable/equatable.dart';

import '../../gallery_screen/models/gallery_image_model.dart';

/// State for GalleryDetailBloc with pagination support
class GalleryDetailState extends Equatable {
  final String galleryId;
  final List<GalleryImageModel> images;
  final bool isLoading;
  final bool isLoadingMore;
  final String? errorMessage;
  final int currentPage;
  final bool hasMore;
  final int pageSize;

  const GalleryDetailState({
    required this.galleryId,
    required this.images,
    required this.isLoading,
    this.isLoadingMore = false,
    this.errorMessage,
    this.currentPage = 1,
    this.hasMore = true,
    this.pageSize = 18, // Load 18 items per page (3 columns x 6 rows)
  });

  factory GalleryDetailState.initial({String galleryId = ''}) {
    return GalleryDetailState(
      galleryId: galleryId,
      images: [],
      isLoading: false,
      isLoadingMore: false,
      errorMessage: null,
      currentPage: 1,
      hasMore: true,
      pageSize: 18,
    );
  }

  GalleryDetailState copyWith({
    String? galleryId,
    List<GalleryImageModel>? images,
    bool? isLoading,
    bool? isLoadingMore,
    String? errorMessage,
    int? currentPage,
    bool? hasMore,
    int? pageSize,
    bool clearError = false,
  }) {
    return GalleryDetailState(
      galleryId: galleryId ?? this.galleryId,
      images: images ?? this.images,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  @override
  List<Object?> get props => [
    galleryId,
    images,
    isLoading,
    isLoadingMore,
    errorMessage,
    currentPage,
    hasMore,
    pageSize,
  ];
}
