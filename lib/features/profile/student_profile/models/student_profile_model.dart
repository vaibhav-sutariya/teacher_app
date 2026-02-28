import 'package:equatable/equatable.dart';

class StudentProfileModel extends Equatable {
  final String name;
  final String studentId;
  final String className;
  final String profileImageUrl;
  final String aboutMe;
  final FamilyInfo familyInfo;
  final BasicInfo basicInfo;
  final CommunicationInfo communicationInfo;
  final AcademicInfo academicInfo;
  final List<DocumentInfo> documents;

  const StudentProfileModel({
    required this.name,
    required this.studentId,
    required this.className,
    required this.profileImageUrl,
    required this.aboutMe,
    required this.familyInfo,
    required this.basicInfo,
    required this.communicationInfo,
    required this.academicInfo,
    required this.documents,
  });

  static StudentProfileModel get mockData => const StudentProfileModel(
    name: 'Alex Johnson',
    studentId: '#STU-10293',
    className: 'CLASS 10-A',
    profileImageUrl: 'assets/images/student_profile.png', // Placeholder
    aboutMe:
        '"Enthusiastic learner with a passion for robotics and mathematics. Aiming to participate in the national science fair this year and pursue engineering in the future."',
    familyInfo: FamilyInfo(
      fatherName: 'BHARATBHAI PATEL',
      fatherOccupation: 'Business',
      fatherContact: '+91 7359235345',
      motherName: 'ANITABEN PATEL',
      motherOccupation: 'Housewife',
      motherContact: '+91 9876543210',
      guardianName: 'SURESHBHAI PATEL',
      guardianOccupation: 'Farmer',
      guardianContact: '+91 1122334455',
      siblingName: 'Rahul Patel',
      siblingClass: 'Class 8-B',
    ),
    basicInfo: BasicInfo(
      dob: '12 Oct 2008',
      gender: 'Male',
      bloodGroup: 'O Positive',
    ),
    communicationInfo: CommunicationInfo(
      address: '123 Maple Street, High-Tech City Park, Springfield',
      pincode: '400102',
      mobile: '+1 (555) 123-4567',
      email: 'alex.j@schoolmail.edu',
    ),
    academicInfo: AcademicInfo(
      penNumber: 'PEN-8890122',
      admissionId: 'ADM/2023/044',
      dateOfAdmission: '05 June 2023',
      rteStudent: 'No',
      previousSchool: 'Northview Elementary International School',
      house: 'Tigers',
      classTeacher: 'Mr. David Smith',
    ),
    documents: [
      DocumentInfo(name: 'AADHAAR CARD', number: '691636379924'),
      DocumentInfo(name: 'AADHAAR DISE', number: '240712043171910067'),
    ],
  );

  @override
  List<Object?> get props => [
    name,
    studentId,
    className,
    profileImageUrl,
    aboutMe,
    familyInfo,
    basicInfo,
    communicationInfo,
    academicInfo,
    documents,
  ];
}

class FamilyInfo extends Equatable {
  final String fatherName;
  final String fatherOccupation;
  final String fatherContact;
  final String motherName;
  final String motherOccupation;
  final String motherContact;
  final String guardianName;
  final String guardianOccupation;
  final String guardianContact;
  final String siblingName;
  final String siblingClass;

  const FamilyInfo({
    required this.fatherName,
    required this.fatherOccupation,
    required this.fatherContact,
    required this.motherName,
    required this.motherOccupation,
    required this.motherContact,
    required this.guardianName,
    required this.guardianOccupation,
    required this.guardianContact,
    required this.siblingName,
    required this.siblingClass,
  });

  @override
  List<Object?> get props => [
    fatherName,
    fatherOccupation,
    fatherContact,
    motherName,
    motherOccupation,
    motherContact,
    guardianName,
    guardianOccupation,
    guardianContact,
    siblingName,
    siblingClass,
  ];
}

class BasicInfo extends Equatable {
  final String dob;
  final String gender;
  final String bloodGroup;

  const BasicInfo({
    required this.dob,
    required this.gender,
    required this.bloodGroup,
  });

  @override
  List<Object?> get props => [dob, gender, bloodGroup];
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

class AcademicInfo extends Equatable {
  final String penNumber;
  final String admissionId;
  final String dateOfAdmission;
  final String rteStudent;
  final String previousSchool;
  final String house;
  final String classTeacher;

  const AcademicInfo({
    required this.penNumber,
    required this.admissionId,
    required this.dateOfAdmission,
    required this.rteStudent,
    required this.previousSchool,
    required this.house,
    required this.classTeacher,
  });

  @override
  List<Object?> get props => [
    penNumber,
    admissionId,
    dateOfAdmission,
    rteStudent,
    previousSchool,
    house,
    classTeacher,
  ];
}

class DocumentInfo extends Equatable {
  final String name;
  final String number;

  const DocumentInfo({required this.name, required this.number});

  @override
  List<Object?> get props => [name, number];
}
