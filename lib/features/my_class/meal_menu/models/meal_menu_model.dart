import 'package:equatable/equatable.dart';

enum MealType {
  breakfast('BREAKFAST'),
  lunch('LUNCH'),
  snacks('SNACKS'),
  dinner('DINNER');

  final String label;
  const MealType(this.label);
}

class MealMenuEntity extends Equatable {
  final String id;
  final DateTime date;
  final MealType mealType;
  final String menuItems;
  final String startTime;
  final String endTime;

  const MealMenuEntity({
    required this.id,
    required this.date,
    required this.mealType,
    required this.menuItems,
    required this.startTime,
    required this.endTime,
  });

  @override
  List<Object?> get props => [
    id,
    date,
    mealType,
    menuItems,
    startTime,
    endTime,
  ];

  // Mock data factory
  static List<MealMenuEntity> getMockData() {
    final today = DateTime.now();
    final tomorrow = today.add(const Duration(days: 1));
    final yesterday = today.subtract(const Duration(days: 1));

    return [
      // Today
      MealMenuEntity(
        id: '1',
        date: today,
        mealType: MealType.breakfast,
        menuItems: 'Dal Fry - Jeera Rice and Papad',
        startTime: '08:00 AM',
        endTime: '08:45 AM',
      ),
      MealMenuEntity(
        id: '2',
        date: today,
        mealType: MealType.lunch,
        menuItems: 'Mix Vegetable Curry, Roti and Salad',
        startTime: '12:30 PM',
        endTime: '01:15 PM',
      ),
      MealMenuEntity(
        id: '3',
        date: today,
        mealType: MealType.snacks,
        menuItems: 'Samosa and Tea',
        startTime: '04:30 PM',
        endTime: '05:00 PM',
      ),

      // Tomorrow
      MealMenuEntity(
        id: '4',
        date: tomorrow,
        mealType: MealType.breakfast,
        menuItems: 'Idli Sambar and Coconut Chutney',
        startTime: '08:00 AM',
        endTime: '08:45 AM',
      ),
      MealMenuEntity(
        id: '5',
        date: tomorrow,
        mealType: MealType.lunch,
        menuItems: 'Paneer Butter Masala, Roti, and Rice',
        startTime: '12:30 PM',
        endTime: '01:15 PM',
      ),
      MealMenuEntity(
        id: '6',
        date: tomorrow,
        mealType: MealType.snacks,
        menuItems: 'Biscuits and Coffee',
        startTime: '04:30 PM',
        endTime: '05:00 PM',
      ),

      // Yesterday
      MealMenuEntity(
        id: '7',
        date: yesterday,
        mealType: MealType.breakfast,
        menuItems: 'Poha and Jalebi',
        startTime: '08:00 AM',
        endTime: '08:45 AM',
      ),
      MealMenuEntity(
        id: '8',
        date: yesterday,
        mealType: MealType.lunch,
        menuItems: 'Rajma Chawal and Salad',
        startTime: '12:30 PM',
        endTime: '01:15 PM',
      ),
    ];
  }
}
