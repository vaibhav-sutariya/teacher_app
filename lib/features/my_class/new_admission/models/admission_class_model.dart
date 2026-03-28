import 'package:equatable/equatable.dart';

class AdmissionClassModel extends Equatable {
  final String className;
  final int count;

  const AdmissionClassModel({
    required this.className,
    required this.count,
  });

  @override
  List<Object?> get props => [className, count];
}
