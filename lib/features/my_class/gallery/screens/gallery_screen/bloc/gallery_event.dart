import 'package:equatable/equatable.dart';

/// Gallery events
abstract class GalleryEvent extends Equatable {
  const GalleryEvent();

  @override
  List<Object?> get props => [];
}

/// Load gallery albums (first page)
class LoadGalleryEvent extends GalleryEvent {
  const LoadGalleryEvent();
}

/// Load more gallery albums (pagination)
class LoadMoreGalleryEvent extends GalleryEvent {
  const LoadMoreGalleryEvent();
}

/// Refresh gallery albums (reset to first page)
class RefreshGalleryEvent extends GalleryEvent {
  const RefreshGalleryEvent();
}
