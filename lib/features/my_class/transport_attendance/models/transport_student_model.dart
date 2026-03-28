import 'package:equatable/equatable.dart';

enum TransportAttendanceStatus { boarded, notBoarded, notMarked }

class TransportStudentModel extends Equatable {
  final String id;
  final String name;
  final String rollNo;
  final String imageUrl;
  final TransportAttendanceStatus status;

  const TransportStudentModel({
    required this.id,
    required this.name,
    required this.rollNo,
    required this.imageUrl,
    this.status = TransportAttendanceStatus.notMarked,
  });

  TransportStudentModel copyWith({
    String? id,
    String? name,
    String? rollNo,
    String? imageUrl,
    TransportAttendanceStatus? status,
  }) {
    return TransportStudentModel(
      id: id ?? this.id,
      name: name ?? this.name,
      rollNo: rollNo ?? this.rollNo,
      imageUrl: imageUrl ?? this.imageUrl,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [id, name, rollNo, imageUrl, status];
}
