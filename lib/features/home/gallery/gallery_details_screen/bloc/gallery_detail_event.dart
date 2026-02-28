import 'package:equatable/equatable.dart';

/// Events for GalleryDetailBloc
abstract class GalleryDetailEvent extends Equatable {
  const GalleryDetailEvent();

  @override
  List<Object?> get props => [];
}

/// Load gallery images event
class LoadGalleryImagesEvent extends GalleryDetailEvent {
  final String galleryId;

  const LoadGalleryImagesEvent({required this.galleryId});

  @override
  List<Object?> get props => [galleryId];
}

/// Refresh gallery images event
class RefreshGalleryImagesEvent extends GalleryDetailEvent {
  final String galleryId;

  const RefreshGalleryImagesEvent({required this.galleryId});

  @override
  List<Object?> get props => [galleryId];
}

/// Load more gallery images event (pagination)
class LoadMoreGalleryImagesEvent extends GalleryDetailEvent {
  const LoadMoreGalleryImagesEvent();
}
