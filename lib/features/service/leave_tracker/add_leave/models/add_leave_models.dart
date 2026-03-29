import 'package:equatable/equatable.dart';

class LeaveTypeModel extends Equatable {
  final String id;
  final String name;

  const LeaveTypeModel({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];

  static List<LeaveTypeModel> getMockTypes() {
    return const [
      LeaveTypeModel(id: '1', name: 'Sick Leave'),
      LeaveTypeModel(id: '2', name: 'Casual Leave'),
      LeaveTypeModel(id: '3', name: 'Earned Leave'),
      LeaveTypeModel(id: '4', name: 'Maternity Leave'),
      LeaveTypeModel(id: '5', name: 'Paternity Leave'),
    ];
  }
}
