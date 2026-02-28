import 'package:equatable/equatable.dart';

/// Holiday type enum
enum HolidayType { national, festival, school }

/// Holiday model - ready for API integration
class HolidayModel extends Equatable {
  final String id;
  final String name;
  final DateTime date;
  final HolidayType type;
  final String? description;

  const HolidayModel({
    required this.id,
    required this.name,
    required this.date,
    required this.type,
    this.description,
  });

  @override
  List<Object?> get props => [id, name, date, type, description];

  /// Static mock data for development
  static List<HolidayModel> getMockData() {
    final now = DateTime.now();
    return [
      // Current month holidays
      HolidayModel(
        id: '1',
        name: 'School Event',
        date: DateTime(now.year, now.month, 15),
        type: HolidayType.school,
        description: 'Annual Day Celebration',
      ),

      // Previous month holidays
      HolidayModel(
        id: '2',
        name: 'Republic Day',
        date: DateTime(now.year, now.month - 1, 26),
        type: HolidayType.national,
        description: 'National Holiday',
      ),

      // Next month holidays
      HolidayModel(
        id: '3',
        name: 'Holi',
        date: DateTime(now.year, now.month + 1, 25),
        type: HolidayType.festival,
        description: 'Festival of Colors',
      ),
      HolidayModel(
        id: '4',
        name: 'Summer Break',
        date: DateTime(now.year, now.month + 2, 15),
        type: HolidayType.school,
        description: 'Summer vacation starts',
      ),
      HolidayModel(
        id: '5',
        name: 'Independence Day',
        date: DateTime(now.year, now.month + 5, 15),
        type: HolidayType.national,
        description: 'National Holiday',
      ),
      HolidayModel(
        id: '6',
        name: 'Diwali',
        date: DateTime(now.year, now.month + 8, 1),
        type: HolidayType.festival,
        description: 'Festival of Lights',
      ),
    ];
  }
}

/// Extension for helper methods
extension HolidayModelExtension on HolidayModel {
  /// Get type color
  int get typeColor {
    switch (type) {
      case HolidayType.national:
        return 0xFFFF5722;
      case HolidayType.festival:
        return 0xFF9C27B0;
      case HolidayType.school:
        return 0xFF2196F3;
    }
  }

  /// Get type display text
  String get typeText {
    switch (type) {
      case HolidayType.national:
        return 'National';
      case HolidayType.festival:
        return 'Festival';
      case HolidayType.school:
        return 'School';
    }
  }

  /// Get formatted date
  String get formattedDate {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
