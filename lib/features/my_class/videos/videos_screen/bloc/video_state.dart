import 'package:equatable/equatable.dart';

import '../models/video_model.dart';

/// Video state with pagination support
class VideoState extends Equatable {
  final bool isLoading;
  final bool isLoadingMore;
  final List<VideoModel> videoList;
  final String? errorMessage;
  final int currentPage;
  final bool hasMore;
  final int pageSize;

  const VideoState({
    this.isLoading = false,
    this.isLoadingMore = false,
    this.videoList = const [],
    this.errorMessage,
    this.currentPage = 1,
    this.hasMore = true,
    this.pageSize = 6, // Load 6 items per page (2 columns x 3 rows)
  });

  VideoState copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    List<VideoModel>? videoList,
    String? errorMessage,
    int? currentPage,
    bool? hasMore,
    int? pageSize,
    bool clearError = false,
  }) {
    return VideoState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      videoList: videoList ?? this.videoList,
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
    videoList,
    errorMessage,
    currentPage,
    hasMore,
    pageSize,
  ];
}
