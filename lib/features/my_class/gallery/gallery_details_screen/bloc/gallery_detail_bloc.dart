import 'package:flutter_bloc/flutter_bloc.dart';

import '../../gallery_screen/repositories/gallery_repository.dart';
import 'gallery_detail_event.dart';
import 'gallery_detail_state.dart';

/// BLoC for managing gallery detail (images) state
class GalleryDetailBloc extends Bloc<GalleryDetailEvent, GalleryDetailState> {
  final GalleryRepository _repository;

  GalleryDetailBloc({required GalleryRepository repository})
    : _repository = repository,
      super(GalleryDetailState.initial()) {
    on<LoadGalleryImagesEvent>(_onLoadGalleryImages);
    on<RefreshGalleryImagesEvent>(_onRefreshGalleryImages);
    on<LoadMoreGalleryImagesEvent>(_onLoadMoreGalleryImages);
  }

  Future<void> _onLoadGalleryImages(
    LoadGalleryImagesEvent event,
    Emitter<GalleryDetailState> emit,
  ) async {
    emit(
      state.copyWith(
        galleryId: event.galleryId,
        isLoading: true,
        errorMessage: null,
        currentPage: 1,
        hasMore: true,
      ),
    );

    try {
      final images = await _repository.getGalleryImages(
        galleryId: event.galleryId,
        page: 1,
        pageSize: state.pageSize,
      );
      emit(
        state.copyWith(
          images: images,
          isLoading: false,
          errorMessage: null,
          currentPage: 1,
          hasMore: images.length >= state.pageSize,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to load gallery images: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> _onRefreshGalleryImages(
    RefreshGalleryImagesEvent event,
    Emitter<GalleryDetailState> emit,
  ) async {
    emit(
      state.copyWith(
        galleryId: event.galleryId,
        isLoading: true,
        errorMessage: null,
        currentPage: 1,
        hasMore: true,
      ),
    );

    try {
      final images = await _repository.getGalleryImages(
        galleryId: event.galleryId,
        page: 1,
        pageSize: state.pageSize,
      );
      emit(
        state.copyWith(
          images: images,
          isLoading: false,
          errorMessage: null,
          currentPage: 1,
          hasMore: images.length >= state.pageSize,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to refresh gallery images: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> _onLoadMoreGalleryImages(
    LoadMoreGalleryImagesEvent event,
    Emitter<GalleryDetailState> emit,
  ) async {
    if (!state.hasMore || state.isLoadingMore) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true));

    try {
      final nextPage = state.currentPage + 1;
      final newImages = await _repository.getGalleryImages(
        galleryId: state.galleryId,
        page: nextPage,
        pageSize: state.pageSize,
      );

      if (newImages.isEmpty) {
        emit(state.copyWith(isLoadingMore: false, hasMore: false));
      } else {
        emit(
          state.copyWith(
            images: [...state.images, ...newImages],
            isLoadingMore: false,
            currentPage: nextPage,
            hasMore: newImages.length >= state.pageSize,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingMore: false,
          errorMessage: 'Failed to load more images: ${e.toString()}',
        ),
      );
    }
  }
}
