import 'package:equatable/equatable.dart';

class TeacherProfileModel extends Equatable {
  final String name;
  final String employeeId;
  final String designation;
  final String profileImageUrl;
  final String aboutMe;
  final String schoolName;
  final String department;
  final String joiningDate;
  final String qualification;
  final String experience;
  final String phoneNumber;
  final BasicInfo basicInfo;
  final CommunicationInfo communicationInfo;
  final List<DocumentInfo> documents;

  const TeacherProfileModel({
    required this.name,
    required this.employeeId,
    required this.designation,
    required this.profileImageUrl,
    required this.aboutMe,
    required this.schoolName,
    required this.department,
    required this.joiningDate,
    required this.qualification,
    required this.experience,
    required this.phoneNumber,
    required this.basicInfo,
    required this.communicationInfo,
    required this.documents,
  });

  static TeacherProfileModel get mockData => const TeacherProfileModel(
    name: 'MISS PATEL DHRUVI',
    employeeId: 'EMP-2041',
    designation: 'Senior Teacher',
    schoolName: 'SSGITS - Maninagar',
    profileImageUrl: 'https://avatar.iran.liara.run/public/girl?username=dhruvi',
    department: 'Mathematics',
    joiningDate: '15/06/2019',
    qualification: 'M.Sc. Mathematics, B.Ed',
    experience: '5 Years',
    phoneNumber: '+91 9876543210',
    aboutMe: '"Passionate about making mathematics accessible and enjoyable for all students."',
    basicInfo: BasicInfo(
      dob: '22/08/1990',
      gender: 'Female',
      bloodGroup: 'B+',
      maritalStatus: 'Unmarried',
    ),
    communicationInfo: CommunicationInfo(
      address: 'A-401, SWASTIK HEIGHTS, NEAR RING ROAD, AHMEDABAD - 380008',
      pincode: '380008',
      mobile: '+91 9876543210',
      email: 'dhruvi.patel@school.edu',
    ),
    documents: [
      DocumentInfo(name: 'Aadhar Card', number: 'XXXX-XXXX-1234'),
      DocumentInfo(name: 'PAN Card', number: 'ABCDE1234F'),
      DocumentInfo(name: 'Degree Certificate', number: 'Submitted'),
    ],
  );

  @override
  List<Object?> get props => [
    name,
    employeeId,
    designation,
    profileImageUrl,
    aboutMe,
    schoolName,
    department,
    joiningDate,
    qualification,
    experience,
    phoneNumber,
    basicInfo,
    communicationInfo,
    documents,
  ];
}

class BasicInfo extends Equatable {
  final String dob;
  final String gender;
  final String bloodGroup;
  final String maritalStatus;

  const BasicInfo({
    required this.dob,
    required this.gender,
    required this.bloodGroup,
    required this.maritalStatus,
  });

  @override
  List<Object?> get props => [dob, gender, bloodGroup, maritalStatus];
}

class CommunicationInfo extends Equatable {
  final String address;
  final String pincode;
  final String mobile;
  final String email;

  const CommunicationInfo({
    required this.address,
    required this.pincode,
    required this.mobile,
    required this.email,
  });

  @override
  List<Object?> get props => [address, pincode, mobile, email];
}

class DocumentInfo extends Equatable {
  final String name;
  final String number;

  const DocumentInfo({required this.name, required this.number});

  @override
  List<Object?> get props => [name, number];
}
