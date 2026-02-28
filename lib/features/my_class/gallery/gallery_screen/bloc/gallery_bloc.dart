import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/gallery_model.dart';
import '../repositories/gallery_repository.dart';
import 'gallery_event.dart';
import 'gallery_state.dart';

/// Production-ready gallery bloc with pagination support
/// Ready for API integration - currently uses mock data
class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final GalleryRepository _galleryRepository;

  GalleryBloc({GalleryRepository? galleryRepository})
    : _galleryRepository = galleryRepository ?? MockGalleryRepository(),
      super(const GalleryState()) {
    // Register event handlers
    on<LoadGalleryEvent>(_onLoadGallery);
    on<LoadMoreGalleryEvent>(_onLoadMoreGallery);
    on<RefreshGalleryEvent>(_onRefreshGallery);

    // Load initial data
    add(const LoadGalleryEvent());
  }

  /// Handle load gallery event
  Future<void> _onLoadGallery(
    LoadGalleryEvent event,
    Emitter<GalleryState> emit,
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
      final galleryData = await _galleryRepository.getGalleryAlbums(
        page: 1,
        pageSize: state.pageSize,
      );
      final galleryList = galleryData
          .map((json) => GalleryModel.fromJson(json))
          .toList();

      emit(
        state.copyWith(
          isLoading: false,
          galleryList: galleryList,
          currentPage: 1,
          hasMore: galleryList.length >= state.pageSize,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to load gallery: ${e.toString()}',
        ),
      );
    }
  }

  /// Handle load more gallery event
  Future<void> _onLoadMoreGallery(
    LoadMoreGalleryEvent event,
    Emitter<GalleryState> emit,
  ) async {
    // Don't load if already loading or no more data
    if (state.isLoadingMore || !state.hasMore) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true));

    try {
      final nextPage = state.currentPage + 1;
      final galleryData = await _galleryRepository.getGalleryAlbums(
        page: nextPage,
        pageSize: state.pageSize,
      );
      final galleryList = galleryData
          .map((json) => GalleryModel.fromJson(json))
          .toList();

      final updatedList = [...state.galleryList, ...galleryList];

      emit(
        state.copyWith(
          isLoadingMore: false,
          galleryList: updatedList,
          currentPage: nextPage,
          hasMore: galleryList.length >= state.pageSize,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingMore: false,
          errorMessage: 'Failed to load more gallery: ${e.toString()}',
        ),
      );
    }
  }

  /// Handle refresh gallery event
  Future<void> _onRefreshGallery(
    RefreshGalleryEvent event,
    Emitter<GalleryState> emit,
  ) async {
    add(const LoadGalleryEvent());
  }
}
