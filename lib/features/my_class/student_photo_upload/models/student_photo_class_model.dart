import 'package:equatable/equatable.dart';

class StudentPhotoClassModel extends Equatable {
  final String className;

  const StudentPhotoClassModel({
    required this.className,
  });

  @override
  List<Object?> get props => [className];
}
