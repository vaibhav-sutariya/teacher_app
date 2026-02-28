import 'package:flutter_bloc/flutter_bloc.dart';

import '../../videos_screen/repositories/video_repository.dart';
import 'video_detail_event.dart';
import 'video_detail_state.dart';

/// BLoC for managing video detail (video items) state
class VideoDetailBloc extends Bloc<VideoDetailEvent, VideoDetailState> {
  final VideoRepository _repository;

  VideoDetailBloc({required VideoRepository repository})
    : _repository = repository,
      super(VideoDetailState.initial()) {
    on<LoadVideoItemsEvent>(_onLoadVideoItems);
    on<RefreshVideoItemsEvent>(_onRefreshVideoItems);
    on<LoadMoreVideoItemsEvent>(_onLoadMoreVideoItems);
  }

  Future<void> _onLoadVideoItems(
    LoadVideoItemsEvent event,
    Emitter<VideoDetailState> emit,
  ) async {
    emit(
      state.copyWith(
        videoAlbumId: event.videoAlbumId,
        isLoading: true,
        errorMessage: null,
        currentPage: 1,
        hasMore: true,
      ),
    );

    try {
      final videos = await _repository.getVideos(
        videoAlbumId: event.videoAlbumId,
        page: 1,
        pageSize: state.pageSize,
      );
      emit(
        state.copyWith(
          videos: videos,
          isLoading: false,
          errorMessage: null,
          currentPage: 1,
          hasMore: videos.length >= state.pageSize,
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

  Future<void> _onRefreshVideoItems(
    RefreshVideoItemsEvent event,
    Emitter<VideoDetailState> emit,
  ) async {
    emit(
      state.copyWith(
        videoAlbumId: event.videoAlbumId,
        isLoading: true,
        errorMessage: null,
        currentPage: 1,
        hasMore: true,
      ),
    );

    try {
      final videos = await _repository.getVideos(
        videoAlbumId: event.videoAlbumId,
        page: 1,
        pageSize: state.pageSize,
      );
      emit(
        state.copyWith(
          videos: videos,
          isLoading: false,
          errorMessage: null,
          currentPage: 1,
          hasMore: videos.length >= state.pageSize,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to refresh videos: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> _onLoadMoreVideoItems(
    LoadMoreVideoItemsEvent event,
    Emitter<VideoDetailState> emit,
  ) async {
    if (!state.hasMore || state.isLoadingMore) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true));

    try {
      final nextPage = state.currentPage + 1;
      final newVideos = await _repository.getVideos(
        videoAlbumId: state.videoAlbumId,
        page: nextPage,
        pageSize: state.pageSize,
      );

      if (newVideos.isEmpty) {
        emit(state.copyWith(isLoadingMore: false, hasMore: false));
      } else {
        emit(
          state.copyWith(
            videos: [...state.videos, ...newVideos],
            isLoadingMore: false,
            currentPage: nextPage,
            hasMore: newVideos.length >= state.pageSize,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingMore: false,
          errorMessage: 'Failed to load more videos: ${e.toString()}',
        ),
      );
    }
  }
}
