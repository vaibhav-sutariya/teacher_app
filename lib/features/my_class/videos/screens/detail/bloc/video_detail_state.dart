import 'package:equatable/equatable.dart';

import '../../../models/video_item_model.dart';

/// State for VideoDetailBloc with pagination support
class VideoDetailState extends Equatable {
  final String videoAlbumId;
  final List<VideoItemModel> videos;
  final bool isLoading;
  final bool isLoadingMore;
  final String? errorMessage;
  final int currentPage;
  final bool hasMore;
  final int pageSize;

  const VideoDetailState({
    required this.videoAlbumId,
    required this.videos,
    required this.isLoading,
    this.isLoadingMore = false,
    this.errorMessage,
    this.currentPage = 1,
    this.hasMore = true,
    this.pageSize = 18, // Load 18 items per page (3 columns x 6 rows)
  });

  factory VideoDetailState.initial({String videoAlbumId = ''}) {
    return VideoDetailState(
      videoAlbumId: videoAlbumId,
      videos: [],
      isLoading: false,
      isLoadingMore: false,
      errorMessage: null,
      currentPage: 1,
      hasMore: true,
      pageSize: 18,
    );
  }

  VideoDetailState copyWith({
    String? videoAlbumId,
    List<VideoItemModel>? videos,
    bool? isLoading,
    bool? isLoadingMore,
    String? errorMessage,
    int? currentPage,
    bool? hasMore,
    int? pageSize,
    bool clearError = false,
  }) {
    return VideoDetailState(
      videoAlbumId: videoAlbumId ?? this.videoAlbumId,
      videos: videos ?? this.videos,
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
    videoAlbumId,
    videos,
    isLoading,
    isLoadingMore,
    errorMessage,
    currentPage,
    hasMore,
    pageSize,
  ];
}
