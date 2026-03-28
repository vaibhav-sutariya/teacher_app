import 'package:equatable/equatable.dart';

enum BirthdayType { student, teacher }

class BirthdayMemberModel extends Equatable {
  final String name;
  final String subTitle; // Class or Department
  final DateTime dob;
  final BirthdayType type;
  final String? profileImage;

  const BirthdayMemberModel({
    required this.name,
    required this.subTitle,
    required this.dob,
    required this.type,
    this.profileImage,
  });

  @override
  List<Object?> get props => [
    name,
    subTitle,
    dob,
    type,
    profileImage,
  ];
}
