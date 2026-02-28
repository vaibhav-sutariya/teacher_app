import '../../gallery_screen/models/gallery_image_model.dart';
import '../../gallery_screen/repositories/gallery_repository.dart';

/// Repository instance for gallery detail
/// In production, this would be injected via dependency injection
class GalleryDetailRepository implements GalleryRepository {
  final MockGalleryRepository _mockRepository = MockGalleryRepository();

  @override
  Future<List<Map<String, dynamic>>> getGalleryAlbums({
    required int page,
    required int pageSize,
  }) {
    return _mockRepository.getGalleryAlbums(page: page, pageSize: pageSize);
  }

  @override
  Future<List<GalleryImageModel>> getGalleryImages({
    required String galleryId,
    required int page,
    required int pageSize,
  }) {
    return _mockRepository.getGalleryImages(
      galleryId: galleryId,
      page: page,
      pageSize: pageSize,
    );
  }
}
