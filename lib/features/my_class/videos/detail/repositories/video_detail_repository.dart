import '../../videos_screen/models/video_item_model.dart';
import '../../videos_screen/repositories/video_repository.dart';

/// Repository instance for video detail
/// In production, this would be injected via dependency injection
class VideoDetailRepository implements VideoRepository {
  final MockVideoRepository _mockRepository = MockVideoRepository();

  @override
  Future<List<Map<String, dynamic>>> getVideoAlbums({
    required int page,
    required int pageSize,
  }) {
    return _mockRepository.getVideoAlbums(page: page, pageSize: pageSize);
  }

  @override
  Future<List<VideoItemModel>> getVideos({
    required String videoAlbumId,
    required int page,
    required int pageSize,
  }) {
    return _mockRepository.getVideos(
      videoAlbumId: videoAlbumId,
      page: page,
      pageSize: pageSize,
    );
  }
}
