import 'package:equatable/equatable.dart';

class SchoolStrengthModel extends Equatable {
  final int totalStudents;
  final int girlsCount;
  final int boysCount;
  final int activeCount;
  final int promotedCount;
  final int newCount;
  final int rteCount;
  final int leftCount;
  final int cancelCount;

  const SchoolStrengthModel({
    required this.totalStudents,
    required this.girlsCount,
    required this.boysCount,
    required this.activeCount,
    required this.promotedCount,
    required this.newCount,
    required this.rteCount,
    required this.leftCount,
    required this.cancelCount,
  });

  @override
  List<Object?> get props => [
        totalStudents,
        girlsCount,
        boysCount,
        activeCount,
        promotedCount,
        newCount,
        rteCount,
        leftCount,
        cancelCount,
      ];
}
