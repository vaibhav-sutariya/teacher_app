class AchievementModel {
  final String id;
  final String title;
  final String description;
  final String date;
  final String category;
  final String imageUrl;

  const AchievementModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.category,
    required this.imageUrl,
  });

  static List<AchievementModel> getMockData() {
    return const [
      AchievementModel(
        id: '1',
        title: 'First Place: Science Fair',
        description:
            'Awarded 1st place in the district science fair for the innovative renewable energy project.',
        date: '12 Nov, 2023',
        category: 'Academics',
        imageUrl:
            'https://images.unsplash.com/photo-1567427017947-545c5f8d16ad?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
      ),
      AchievementModel(
        id: '2',
        title: 'MVP: Inter-school Basketball',
        description:
            'Recognized as the Most Valuable Player during the annual inter-school basketball tournament.',
        date: '04 Feb, 2024',
        category: 'Sports',
        imageUrl:
            'https://images.unsplash.com/photo-1546519638-68e109498ffc?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
      ),
      AchievementModel(
        id: '3',
        title: 'Perfect Attendance Award',
        description:
            'Maintained 100% attendance throughout the entire academic year.',
        date: '15 May, 2024',
        category: 'General',
        imageUrl:
            'https://images.unsplash.com/photo-1523289333742-be1143f6b766?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
      ),
    ];
  }
}
