import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/video_model.dart';
import '../repositories/video_repository.dart';
import 'video_event.dart';
import 'video_state.dart';

/// Production-ready video bloc with pagination support
/// Ready for API integration - currently uses mock data
class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final VideoRepository _videoRepository;

  VideoBloc({VideoRepository? videoRepository})
    : _videoRepository = videoRepository ?? MockVideoRepository(),
      super(const VideoState()) {
    // Register event handlers
    on<LoadVideoEvent>(_onLoadVideo);
    on<LoadMoreVideoEvent>(_onLoadMoreVideo);
    on<RefreshVideoEvent>(_onRefreshVideo);

    // Load initial data
    add(const LoadVideoEvent());
  }

  /// Handle load video event
  Future<void> _onLoadVideo(
    LoadVideoEvent event,
    Emitter<VideoState> emit,
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
      final videoData = await _videoRepository.getVideoAlbums(
        page: 1,
        pageSize: state.pageSize,
      );
      final videoList = videoData
          .map((json) => VideoModel.fromJson(json))
          .toList();

      emit(
        state.copyWith(
          isLoading: false,
          videoList: videoList,
          currentPage: 1,
          hasMore: videoList.length >= state.pageSize,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to load videos: ${e.toString()}',
        ),
      );
    }
  }

  /// Handle load more video event
  Future<void> _onLoadMoreVideo(
    LoadMoreVideoEvent event,
    Emitter<VideoState> emit,
  ) async {
    // Don't load if already loading or no more data
    if (state.isLoadingMore || !state.hasMore) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true));

    try {
      final nextPage = state.currentPage + 1;
      final videoData = await _videoRepository.getVideoAlbums(
        page: nextPage,
        pageSize: state.pageSize,
      );
      final videoList = videoData
          .map((json) => VideoModel.fromJson(json))
          .toList();

      final updatedList = [...state.videoList, ...videoList];

      emit(
        state.copyWith(
          isLoadingMore: false,
          videoList: updatedList,
          currentPage: nextPage,
          hasMore: videoList.length >= state.pageSize,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingMore: false,
          errorMessage: 'Failed to load more videos: ${e.toString()}',
        ),
      );
    }
  }

  /// Handle refresh video event
  Future<void> _onRefreshVideo(
    RefreshVideoEvent event,
    Emitter<VideoState> emit,
  ) async {
    add(const LoadVideoEvent());
  }
}
