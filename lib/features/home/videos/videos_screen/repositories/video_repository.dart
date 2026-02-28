import '../models/video_item_model.dart';

/// Video repository - ready for API integration
/// Currently uses mock data, but structured for easy API integration
abstract class VideoRepository {
  /// Fetch video albums with pagination
  Future<List<Map<String, dynamic>>> getVideoAlbums({
    required int page,
    required int pageSize,
  });

  /// Fetch videos for a specific video album with pagination
  Future<List<VideoItemModel>> getVideos({
    required String videoAlbumId,
    required int page,
    required int pageSize,
  });
}

/// Mock implementation of VideoRepository
class MockVideoRepository implements VideoRepository {
  // All mock data - will be paginated
  static final List<Map<String, dynamic>> _allMockData = [
    {
      'id': 'video_001',
      'title': 'Annual Day Performance',
      'thumbnailUrl':
          'https://images.unsplash.com/photo-1511578314322-379afb476865?w=400',
      'videoCount': 15,
      'createdAt': '2023-01-15',
    },
    {
      'id': 'video_002',
      'title': 'Sports Day Highlights',
      'thumbnailUrl':
          'https://images.unsplash.com/photo-1579952363873-27f3bade9f55?w=400',
      'videoCount': 28,
      'createdAt': '2023-02-20',
    },
    {
      'id': 'video_003',
      'title': 'Science Fair Presentations',
      'thumbnailUrl':
          'https://images.unsplash.com/photo-1532094349884-543bc11b234d?w=400',
      'videoCount': 12,
      'createdAt': '2023-03-10',
    },
    {
      'id': 'video_004',
      'title': 'Field Trip Memories',
      'thumbnailUrl':
          'https://images.unsplash.com/photo-1519904981063-b0cf448d479e?w=400',
      'videoCount': 22,
      'createdAt': '2023-04-05',
    },
    {
      'id': 'video_005',
      'title': 'Reading Week Activities',
      'thumbnailUrl':
          'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400',
      'videoCount': 8,
      'createdAt': '2023-05-12',
    },
    {
      'id': 'video_006',
      'title': 'Music Festival',
      'thumbnailUrl':
          'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=400',
      'videoCount': 35,
      'createdAt': '2023-06-18',
    },
    {
      'id': 'video_007',
      'title': 'Graduation Ceremony',
      'thumbnailUrl':
          'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=400',
      'videoCount': 45,
      'createdAt': '2023-07-25',
    },
    {
      'id': 'video_008',
      'title': 'Art Exhibition',
      'thumbnailUrl':
          'https://images.unsplash.com/photo-1513475382585-d06e58bcb0e0?w=400',
      'videoCount': 18,
      'createdAt': '2023-08-10',
    },
    {
      'id': 'video_009',
      'title': 'Zoo Visit',
      'thumbnailUrl':
          'https://images.unsplash.com/photo-1548199973-03cce0bbc87b?w=400',
      'videoCount': 30,
      'createdAt': '2023-09-05',
    },
    {
      'id': 'video_010',
      'title': 'Math Olympiad',
      'thumbnailUrl':
          'https://images.unsplash.com/photo-1509228468518-180dd4864904?w=400',
      'videoCount': 14,
      'createdAt': '2023-10-12',
    },
    {
      'id': 'video_011',
      'title': 'Drama Competition',
      'thumbnailUrl':
          'https://images.unsplash.com/photo-1503095396549-807759245b35?w=400',
      'videoCount': 25,
      'createdAt': '2023-11-08',
    },
    {
      'id': 'video_012',
      'title': 'Christmas Celebration',
      'thumbnailUrl':
          'https://images.unsplash.com/photo-1482517967863-00e15c9b44be?w=400',
      'videoCount': 40,
      'createdAt': '2023-12-20',
    },
    {
      'id': 'video_013',
      'title': 'Robotics Workshop',
      'thumbnailUrl':
          'https://images.unsplash.com/photo-1518770660439-4636190af475?w=400',
      'videoCount': 20,
      'createdAt': '2024-01-15',
    },
    {
      'id': 'video_014',
      'title': 'Debate Competition',
      'thumbnailUrl':
          'https://images.unsplash.com/photo-1505373877841-8d25f7d46678?w=400',
      'videoCount': 16,
      'createdAt': '2024-02-10',
    },
    {
      'id': 'video_015',
      'title': 'Cultural Fest',
      'thumbnailUrl':
          'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=400',
      'videoCount': 55,
      'createdAt': '2024-03-18',
    },
    {
      'id': 'video_016',
      'title': 'Environment Day',
      'thumbnailUrl':
          'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?w=400',
      'videoCount': 19,
      'createdAt': '2024-04-22',
    },
    {
      'id': 'video_017',
      'title': 'Coding Bootcamp',
      'thumbnailUrl':
          'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=400',
      'videoCount': 32,
      'createdAt': '2024-05-14',
    },
    {
      'id': 'video_018',
      'title': 'Independence Day',
      'thumbnailUrl':
          'https://images.unsplash.com/photo-1526304640581-d334cdbbf45e?w=400',
      'videoCount': 38,
      'createdAt': '2024-06-15',
    },
    {
      'id': 'video_019',
      'title': 'Book Fair',
      'thumbnailUrl':
          'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?w=400',
      'videoCount': 24,
      'createdAt': '2024-07-08',
    },
    {
      'id': 'video_020',
      'title': 'Teachers Day',
      'thumbnailUrl':
          'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?w=400',
      'videoCount': 29,
      'createdAt': '2024-08-05',
    },
    {
      'id': 'video_021',
      'title': 'Science Week',
      'thumbnailUrl':
          'https://images.unsplash.com/photo-1532094349884-543bc11b234d?w=400',
      'videoCount': 21,
      'createdAt': '2024-09-12',
    },
    {
      'id': 'video_022',
      'title': 'Diwali Celebration',
      'thumbnailUrl':
          'https://images.unsplash.com/photo-1606220945770-b5b6c2c55bf1?w=400',
      'videoCount': 42,
      'createdAt': '2024-10-28',
    },
    {
      'id': 'video_023',
      'title': 'Sports Tournament',
      'thumbnailUrl':
          'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400',
      'videoCount': 48,
      'createdAt': '2024-11-15',
    },
    {
      'id': 'video_024',
      'title': 'School Assembly',
      'thumbnailUrl':
          'https://images.unsplash.com/photo-1556910103-1c02745aae4d?w=400',
      'videoCount': 36,
      'createdAt': '2024-12-20',
    },
  ];

  // Cache for generated videos to avoid regenerating on pagination
  static final Map<String, List<VideoItemModel>> _videoCache = {};

  @override
  Future<List<Map<String, dynamic>>> getVideoAlbums({
    required int page,
    required int pageSize,
  }) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Calculate pagination
    final startIndex = (page - 1) * pageSize;
    final endIndex = startIndex + pageSize;

    // Return paginated data
    if (startIndex >= _allMockData.length) {
      return [];
    }

    return _allMockData.sublist(
      startIndex,
      endIndex > _allMockData.length ? _allMockData.length : endIndex,
    );
  }

  /// Generate mock videos for a video album
  /// In production, this would fetch from API
  List<VideoItemModel> _generateMockVideos(String videoAlbumId, int count) {
    final videoUrls = [
      'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
      'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
      'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
      'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
      'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
      'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4',
      'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
      'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4',
      'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4',
    ];

    final thumbnailUrls = [
      'https://images.unsplash.com/photo-1556910103-1c02745aae4d?w=400',
      'https://images.unsplash.com/photo-1579952363873-27f3bade9f55?w=400',
      'https://images.unsplash.com/photo-1532094349884-543bc11b234d?w=400',
      'https://images.unsplash.com/photo-1519904981063-b0cf448d479e?w=400',
      'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400',
      'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=400',
      'https://images.unsplash.com/photo-1511578314322-379afb476865?w=400',
      'https://images.unsplash.com/photo-1513475382585-d06e58bcb0e0?w=400',
      'https://images.unsplash.com/photo-1548199973-03cce0bbc87b?w=400',
      'https://images.unsplash.com/photo-1509228468518-180dd4864904?w=400',
    ];

    final durations = [
      '2:30',
      '3:15',
      '1:45',
      '4:20',
      '2:10',
      '5:00',
      '3:45',
      '2:55',
      '4:10',
      '3:30',
    ];

    return List.generate(
      count,
      (index) => VideoItemModel(
        id: '${videoAlbumId}_vid_${index + 1}',
        videoUrl: videoUrls[index % videoUrls.length],
        thumbnailUrl: thumbnailUrls[index % thumbnailUrls.length],
        duration: durations[index % durations.length],
        createdAt: DateTime.now()
            .subtract(Duration(days: count - index))
            .toIso8601String(),
      ),
    );
  }

  @override
  Future<List<VideoItemModel>> getVideos({
    required String videoAlbumId,
    required int page,
    required int pageSize,
  }) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Find the video album to get its video count
    final videoAlbum = _allMockData.firstWhere(
      (v) => v['id'] == videoAlbumId,
      orElse: () => {'videoCount': 20},
    );

    final videoCount = videoAlbum['videoCount'] as int? ?? 20;

    // Generate all videos if not cached, or use cached version
    if (!_videoCache.containsKey(videoAlbumId)) {
      _videoCache[videoAlbumId] = _generateMockVideos(videoAlbumId, videoCount);
    }

    final allVideos = _videoCache[videoAlbumId]!;

    // Calculate pagination
    final startIndex = (page - 1) * pageSize;
    final endIndex = startIndex + pageSize;

    // Return paginated data
    if (startIndex >= allVideos.length) {
      return [];
    }

    return allVideos.sublist(
      startIndex,
      endIndex > allVideos.length ? allVideos.length : endIndex,
    );
  }
}
