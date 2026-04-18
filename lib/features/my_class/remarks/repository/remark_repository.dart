import '../models/remark_model.dart';

/// Remark repository - ready for API integration
/// Currently uses mock data, but structured for easy API integration
abstract class RemarkRepository {
  /// Fetch remarks with optional filters and pagination (supports multiple selections)
  Future<List<Map<String, dynamic>>> getRemarks({
    List<RemarkCategory> categories = const [],
    List<RemarkType> types = const [],
    int page = 1,
    int pageSize = 10,
  });
}

/// Mock implementation of RemarkRepository
class MockRemarkRepository implements RemarkRepository {
  // All mock data
  static final List<Map<String, dynamic>> _allMockData = [
    {
      'id': 'remark_001',
      'date': '2026-01-28',
      'category': 'daily_routine',
      'type': 'negative',
      'severity': 'critical',
      'description': 'Did not bring the subject book for mathematics class.',
      'createdAt': '2026-01-28T10:30:00Z',
    },
    {
      'id': 'remark_002',
      'date': '2026-01-16',
      'category': 'behaviour',
      'type': 'positive',
      'severity': 'excellent',
      'description':
          'Your ward possesses good etiquette and helps peers in class activities.',
      'createdAt': '2026-01-16T14:20:00Z',
    },
    {
      'id': 'remark_003',
      'date': '2026-01-13',
      'category': 'class_work',
      'type': 'positive',
      'severity': null,
      'description':
          'Completes the assigned classwork within the stipulated time regularly.',
      'createdAt': '2026-01-13T11:15:00Z',
    },
    {
      'id': 'remark_004',
      'date': '2026-01-09',
      'category': 'daily_routine',
      'type': 'negative',
      'severity': null,
      'description':
          'Late coming noted. Please ensure the student arrives by 8:00 AM.',
      'createdAt': '2026-01-09T08:45:00Z',
    },
    {
      'id': 'remark_005',
      'date': '2025-12-26',
      'category': 'daily_routine',
      'type': 'negative',
      'severity': null,
      'description': 'Not brought subject book for science experiment.',
      'createdAt': '2025-12-26T09:30:00Z',
    },
    {
      'id': 'remark_006',
      'date': '2025-12-08',
      'category': 'daily_routine',
      'type': 'negative',
      'severity': null,
      'description': 'Not brought class work notebook.',
      'createdAt': '2025-12-08T10:00:00Z',
    },
    {
      'id': 'remark_007',
      'date': '2025-11-20',
      'category': 'behaviour',
      'type': 'positive',
      'severity': null,
      'description':
          'Shows great respect towards teachers and follows classroom rules.',
      'createdAt': '2025-11-20T13:45:00Z',
    },
    {
      'id': 'remark_008',
      'date': '2025-11-15',
      'category': 'class_work',
      'type': 'negative',
      'severity': 'critical',
      'description':
          'Did not submit homework assignment for three consecutive days.',
      'createdAt': '2025-11-15T12:30:00Z',
    },
    {
      'id': 'remark_009',
      'date': '2025-11-10',
      'category': 'behaviour',
      'type': 'positive',
      'severity': 'excellent',
      'description':
          'Demonstrates excellent leadership skills in group activities.',
      'createdAt': '2025-11-10T15:20:00Z',
    },
    {
      'id': 'remark_010',
      'date': '2025-11-05',
      'category': 'class_work',
      'type': 'positive',
      'severity': null,
      'description': 'Shows improvement in mathematics problem-solving skills.',
      'createdAt': '2025-11-05T11:00:00Z',
    },
    {
      'id': 'remark_011',
      'date': '2025-10-28',
      'category': 'daily_routine',
      'type': 'negative',
      'severity': null,
      'description': 'Forgot to bring PE uniform for physical education class.',
      'createdAt': '2025-10-28T09:15:00Z',
    },
    {
      'id': 'remark_012',
      'date': '2025-10-22',
      'category': 'behaviour',
      'type': 'negative',
      'severity': null,
      'description': 'Talking during class without permission.',
      'createdAt': '2025-10-22T10:30:00Z',
    },
    {
      'id': 'remark_013',
      'date': '2025-10-18',
      'category': 'class_work',
      'type': 'positive',
      'severity': null,
      'description':
          'Actively participates in class discussions and asks thoughtful questions.',
      'createdAt': '2025-10-18T14:00:00Z',
    },
    {
      'id': 'remark_014',
      'date': '2025-10-12',
      'category': 'daily_routine',
      'type': 'positive',
      'severity': null,
      'description': 'Always arrives on time and is well-prepared for classes.',
      'createdAt': '2025-10-12T08:00:00Z',
    },
    {
      'id': 'remark_015',
      'date': '2025-10-05',
      'category': 'behaviour',
      'type': 'positive',
      'severity': 'excellent',
      'description':
          'Helps other students understand difficult concepts during study time.',
      'createdAt': '2025-10-05T13:30:00Z',
    },
  ];

  @override
  Future<List<Map<String, dynamic>>> getRemarks({
    List<RemarkCategory> categories = const [],
    List<RemarkType> types = const [],
    int page = 1,
    int pageSize = 10,
  }) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    var filteredData = List<Map<String, dynamic>>.from(_allMockData);

    // Apply category filters (multiple selection)
    if (categories.isNotEmpty) {
      final categoryStrings = categories.map((cat) {
        switch (cat) {
          case RemarkCategory.dailyRoutine:
            return 'daily_routine';
          case RemarkCategory.behaviour:
            return 'behaviour';
          case RemarkCategory.classWork:
            return 'class_work';
        }
      }).toSet();

      filteredData = filteredData.where((remark) {
        final remarkCategory = remark['category'] as String;
        return categoryStrings.contains(remarkCategory);
      }).toList();
    }

    // Apply type filters (multiple selection)
    if (types.isNotEmpty) {
      final typeStrings = types.map((type) => type.name).toSet();

      filteredData = filteredData.where((remark) {
        final remarkType = remark['type'] as String;
        return typeStrings.contains(remarkType);
      }).toList();
    }

    // Sort by date (newest first)
    filteredData.sort((a, b) {
      final dateA = DateTime.parse(a['date'] as String);
      final dateB = DateTime.parse(b['date'] as String);
      return dateB.compareTo(dateA);
    });

    // Apply pagination
    final startIndex = (page - 1) * pageSize;
    final endIndex = startIndex + pageSize;

    if (startIndex >= filteredData.length) {
      return [];
    }

    return filteredData.sublist(
      startIndex,
      endIndex > filteredData.length ? filteredData.length : endIndex,
    );
  }
}
