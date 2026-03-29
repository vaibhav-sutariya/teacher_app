import 'package:equatable/equatable.dart';

class EnquiryModel extends Equatable {
  final DateTime date;
  final int admittedCount;
  final int enquiryCount;
  final int registrationCount;

  const EnquiryModel({
    required this.date,
    required this.admittedCount,
    required this.enquiryCount,
    required this.registrationCount,
  });

  @override
  List<Object?> get props => [date, admittedCount, enquiryCount, registrationCount];
}
