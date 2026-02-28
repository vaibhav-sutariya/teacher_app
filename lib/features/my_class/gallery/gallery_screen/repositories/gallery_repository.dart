import '../models/gallery_image_model.dart';

/// Gallery repository - ready for API integration
/// Currently uses mock data, but structured for easy API integration
abstract class GalleryRepository {
  /// Fetch gallery albums with pagination
  Future<List<Map<String, dynamic>>> getGalleryAlbums({
    required int page,
    required int pageSize,
  });

  /// Fetch images for a specific gallery album with pagination
  Future<List<GalleryImageModel>> getGalleryImages({
    required String galleryId,
    required int page,
    required int pageSize,
  });
}

/// Mock implementation of GalleryRepository
class MockGalleryRepository implements GalleryRepository {
  // All mock data - will be paginated
  static final List<Map<String, dynamic>> _allMockData = [
    {
      'id': 'gallery_001',
      'title': 'Fireless Cooking',
      'imageUrl':
          'https://images.unsplash.com/photo-1556910103-1c02745aae4d?w=400',
      'photoCount': 20,
      'createdAt': '2023-01-15',
    },
    {
      'id': 'gallery_002',
      'title': 'Sports Day 2023',
      'imageUrl':
          'https://images.unsplash.com/photo-1579952363873-27f3bade9f55?w=400',
      'photoCount': 145,
      'createdAt': '2023-02-20',
    },
    {
      'id': 'gallery_003',
      'title': 'Science Fair',
      'imageUrl':
          'https://images.unsplash.com/photo-1532094349884-543bc11b234d?w=400',
      'photoCount': 42,
      'createdAt': '2023-03-10',
    },
    {
      'id': 'gallery_004',
      'title': 'Museum Trip',
      'imageUrl':
          'https://images.unsplash.com/photo-1519904981063-b0cf448d479e?w=400',
      'photoCount': 56,
      'createdAt': '2023-04-05',
    },
    {
      'id': 'gallery_005',
      'title': 'Reading Week',
      'imageUrl':
          'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400',
      'photoCount': 12,
      'createdAt': '2023-05-12',
    },
    {
      'id': 'gallery_006',
      'title': 'Music Fest',
      'imageUrl':
          'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=400',
      'photoCount': 69,
      'createdAt': '2023-06-18',
    },
    {
      'id': 'gallery_007',
      'title': 'Annual Day Celebration',
      'imageUrl':
          'https://images.unsplash.com/photo-1511578314322-379afb476865?w=400',
      'photoCount': 234,
      'createdAt': '2023-07-25',
    },
    {
      'id': 'gallery_008',
      'title': 'Art Exhibition',
      'imageUrl':
          'https://images.unsplash.com/photo-1513475382585-d06e58bcb0e0?w=400',
      'photoCount': 87,
      'createdAt': '2023-08-10',
    },
    {
      'id': 'gallery_009',
      'title': 'Field Trip to Zoo',
      'imageUrl':
          'https://images.unsplash.com/photo-1548199973-03cce0bbc87b?w=400',
      'photoCount': 156,
      'createdAt': '2023-09-05',
    },
    {
      'id': 'gallery_010',
      'title': 'Math Olympiad',
      'imageUrl':
          'https://images.unsplash.com/photo-1509228468518-180dd4864904?w=400',
      'photoCount': 45,
      'createdAt': '2023-10-12',
    },
    {
      'id': 'gallery_011',
      'title': 'Drama Competition',
      'imageUrl':
          'https://images.unsplash.com/photo-1503095396549-807759245b35?w=400',
      'photoCount': 98,
      'createdAt': '2023-11-08',
    },
    {
      'id': 'gallery_012',
      'title': 'Christmas Celebration',
      'imageUrl':
          'https://images.unsplash.com/photo-1482517967863-00e15c9b44be?w=400',
      'photoCount': 178,
      'createdAt': '2023-12-20',
    },
    {
      'id': 'gallery_013',
      'title': 'Robotics Workshop',
      'imageUrl':
          'https://images.unsplash.com/photo-1518770660439-4636190af475?w=400',
      'photoCount': 67,
      'createdAt': '2024-01-15',
    },
    {
      'id': 'gallery_014',
      'title': 'Debate Competition',
      'imageUrl':
          'https://images.unsplash.com/photo-1505373877841-8d25f7d46678?w=400',
      'photoCount': 54,
      'createdAt': '2024-02-10',
    },
    {
      'id': 'gallery_015',
      'title': 'Cultural Fest',
      'imageUrl':
          'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=400',
      'photoCount': 312,
      'createdAt': '2024-03-18',
    },
    {
      'id': 'gallery_016',
      'title': 'Environment Day',
      'imageUrl':
          'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?w=400',
      'photoCount': 89,
      'createdAt': '2024-04-22',
    },
    {
      'id': 'gallery_017',
      'title': 'Coding Bootcamp',
      'imageUrl':
          'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=400',
      'photoCount': 123,
      'createdAt': '2024-05-14',
    },
    {
      'id': 'gallery_018',
      'title': 'Independence Day',
      'imageUrl':
          'https://images.unsplash.com/photo-1526304640581-d334cdbbf45e?w=400',
      'photoCount': 201,
      'createdAt': '2024-06-15',
    },
    {
      'id': 'gallery_019',
      'title': 'Book Fair',
      'imageUrl':
          'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?w=400',
      'photoCount': 76,
      'createdAt': '2024-07-08',
    },
    {
      'id': 'gallery_020',
      'title': 'Teachers Day',
      'imageUrl':
          'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?w=400',
      'photoCount': 134,
      'createdAt': '2024-08-05',
    },
    {
      'id': 'gallery_021',
      'title': 'Science Week',
      'imageUrl':
          'https://images.unsplash.com/photo-1532094349884-543bc11b234d?w=400',
      'photoCount': 92,
      'createdAt': '2024-09-12',
    },
    {
      'id': 'gallery_022',
      'title': 'Diwali Celebration',
      'imageUrl':
          'https://images.unsplash.com/photo-1606220945770-b5b6c2c55bf1?w=400',
      'photoCount': 167,
      'createdAt': '2024-10-28',
    },
    {
      'id': 'gallery_023',
      'title': 'Sports Tournament',
      'imageUrl':
          'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400',
      'photoCount': 289,
      'createdAt': '2024-11-15',
    },
    {
      'id': 'gallery_024',
      'title': 'Graduation Ceremony',
      'imageUrl':
          'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=400',
      'photoCount': 445,
      'createdAt': '2024-12-20',
    },
  ];

  @override
  Future<List<Map<String, dynamic>>> getGalleryAlbums({
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

  /// Generate mock images for a gallery
  /// In production, this would fetch from API
  List<GalleryImageModel> _generateMockImages(String galleryId, int count) {
    final baseUrls = [
      'https://images.unsplash.com/photo-1556910103-1c02745aae4d?w=800',
      'https://images.unsplash.com/photo-1579952363873-27f3bade9f55?w=800',
      'https://images.unsplash.com/photo-1532094349884-543bc11b234d?w=800',
      'https://images.unsplash.com/photo-1519904981063-b0cf448d479e?w=800',
      'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=800',
      'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=800',
      'https://images.unsplash.com/photo-1511578314322-379afb476865?w=800',
      'https://images.unsplash.com/photo-1513475382585-d06e58bcb0e0?w=800',
      'https://images.unsplash.com/photo-1548199973-03cce0bbc87b?w=800',
      'https://images.unsplash.com/photo-1509228468518-180dd4864904?w=800',
      'https://images.unsplash.com/photo-1503095396549-807759245b35?w=800',
      'https://images.unsplash.com/photo-1482517967863-00e15c9b44be?w=800',
      'https://images.unsplash.com/photo-1518770660439-4636190af475?w=800',
      'https://images.unsplash.com/photo-1505373877841-8d25f7d46678?w=800',
      'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=800',
      'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?w=800',
      'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=800',
      'https://images.unsplash.com/photo-1526304640581-d334cdbbf45e?w=800',
      'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?w=800',
      'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?w=800',
      'https://images.unsplash.com/photo-1606220945770-b5b6c2c55bf1?w=800',
      'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800',
      'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=800',
    ];

    return List.generate(
      count,
      (index) => GalleryImageModel(
        id: '${galleryId}_img_${index + 1}',
        imageUrl: baseUrls[index % baseUrls.length],
        thumbnailUrl: baseUrls[index % baseUrls.length].replaceAll(
          'w=800',
          'w=400',
        ),
        createdAt: DateTime.now()
            .subtract(Duration(days: count - index))
            .toIso8601String(),
      ),
    );
  }

  // Cache for generated images to avoid regenerating on pagination
  static final Map<String, List<GalleryImageModel>> _imageCache = {};

  @override
  Future<List<GalleryImageModel>> getGalleryImages({
    required String galleryId,
    required int page,
    required int pageSize,
  }) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Find the gallery to get its photo count
    final gallery = _allMockData.firstWhere(
      (g) => g['id'] == galleryId,
      orElse: () => {'photoCount': 20},
    );

    final photoCount = gallery['photoCount'] as int? ?? 20;

    // Generate all images if not cached, or use cached version
    if (!_imageCache.containsKey(galleryId)) {
      _imageCache[galleryId] = _generateMockImages(galleryId, photoCount);
    }

    final allImages = _imageCache[galleryId]!;

    // Calculate pagination
    final startIndex = (page - 1) * pageSize;
    final endIndex = startIndex + pageSize;

    // Return paginated data
    if (startIndex >= allImages.length) {
      return [];
    }

    return allImages.sublist(
      startIndex,
      endIndex > allImages.length ? allImages.length : endIndex,
    );
  }
}
