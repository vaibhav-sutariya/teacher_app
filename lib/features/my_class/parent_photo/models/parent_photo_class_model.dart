import 'package:equatable/equatable.dart';

class ParentPhotoClassModel extends Equatable {
  final String className;

  const ParentPhotoClassModel({
    required this.className,
  });

  @override
  List<Object?> get props => [className];
}
