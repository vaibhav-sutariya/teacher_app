import 'package:equatable/equatable.dart';

class StaffMember extends Equatable {
  final String id;
  final String name;
  final String designation;
  final String? profileImage;

  const StaffMember({
    required this.id,
    required this.name,
    required this.designation,
    this.profileImage,
  });

  @override
  List<Object?> get props => [id, name, designation, profileImage];

  static List<StaffMember> getMockStaff() {
    return const [
      StaffMember(id: '1', name: 'AKSHIT GOLANIYA', designation: 'ADMIN'),
      StaffMember(id: '2', name: 'ANUPAMA PRAJAPATI', designation: 'ACADEMICS'),
      StaffMember(id: '3', name: 'ARYAN MANDALIYA', designation: 'ADMIN'),
      StaffMember(id: '4', name: 'ASHA NADIA', designation: 'HOUSEKEEPING'),
      StaffMember(id: '5', name: 'ASHABEN VAGHELA', designation: 'HOUSEKEEPING'),
      StaffMember(id: '6', name: 'AYUSHI KHATRI', designation: 'ACADEMICS'),
      StaffMember(id: '7', name: 'BALJINDER KAUR BHARDWAJ', designation: 'ACADEMICS'),
      StaffMember(id: '8', name: 'BHARTIBEN VAGHELA', designation: 'HOUSEKEEPING'),
      StaffMember(id: '9', name: 'BHAVIKBHAI PATEL', designation: 'ACADEMICS'),
      StaffMember(id: '10', name: 'BHAVIN SOLANKI', designation: 'ACADEMICS'),
      StaffMember(id: '11', name: 'CHETAN PARMAR', designation: 'ADMIN'),
      StaffMember(id: '12', name: 'DHRUTI MEHTA', designation: 'ACADEMICS'),
      StaffMember(id: '13', name: 'FARHAN SHAIKH', designation: 'HOUSEKEEPING'),
      StaffMember(id: '14', name: 'GAYATRI TRIVEDI', designation: 'ACADEMICS'),
      StaffMember(id: '15', name: 'HARSHIL SHAH', designation: 'ADMIN'),
      StaffMember(id: '16', name: 'ISHA PATEL', designation: 'ACADEMICS'),
      StaffMember(id: '17', name: 'JAYESH CHAUHAN', designation: 'HOUSEKEEPING'),
      StaffMember(id: '18', name: 'KRISHNA REDDY', designation: 'ACADEMICS'),
      StaffMember(id: '19', name: 'LALITA DEVI', designation: 'HOUSEKEEPING'),
      StaffMember(id: '20', name: 'MANTHAN JOSHI', designation: 'ADMIN'),
      StaffMember(id: '21', name: 'NEHA GUPTA', designation: 'ACADEMICS'),
      StaffMember(id: '22', name: 'OM PRAKASH', designation: 'HOUSEKEEPING'),
      StaffMember(id: '23', name: 'PRIYA SHARMA', designation: 'ACADEMICS'),
      StaffMember(id: '24', name: 'RAHUL VERMA', designation: 'ADMIN'),
      StaffMember(id: '25', name: 'SUNITA SINGH', designation: 'HOUSEKEEPING'),
      StaffMember(id: '26', name: 'TANMAY DESAI', designation: 'ACADEMICS'),
      StaffMember(id: '27', name: 'URVASHI PATEL', designation: 'ACADEMICS'),
      StaffMember(id: '28', name: 'VIPUL RANA', designation: 'ADMIN'),
      StaffMember(id: '29', name: 'YASHVI SHAH', designation: 'ACADEMICS'),
      StaffMember(id: '30', name: 'ZUBIN KHAN', designation: 'HOUSEKEEPING'),
    ];
  }
}
