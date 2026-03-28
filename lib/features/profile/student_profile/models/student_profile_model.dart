import 'package:equatable/equatable.dart';

class StudentProfileModel extends Equatable {
  final String name;
  final String studentId;
  final String className;
  final String profileImageUrl;
  final String aboutMe;
  final String schoolName;
  final String grNo;
  final String rollNo;
  final String phoneNumber;
  final FamilyInfo familyInfo;
  final BasicInfo basicInfo;
  final CommunicationInfo communicationInfo;
  final AcademicInfo academicInfo;
  final List<DocumentInfo> documents;
  final EnquiryInfo enquiryInfo;

  const StudentProfileModel({
    required this.name,
    required this.studentId,
    required this.className,
    required this.profileImageUrl,
    required this.aboutMe,
    required this.schoolName,
    required this.grNo,
    required this.rollNo,
    required this.phoneNumber,
    required this.familyInfo,
    required this.basicInfo,
    required this.communicationInfo,
    required this.academicInfo,
    required this.documents,
    required this.enquiryInfo,
  });

  static StudentProfileModel get mockData => const StudentProfileModel(
    name: 'THAKKAR HARSH KEYUR',
    studentId: '#STU-10293',
    className: 'Jr.KG - JAL',
    schoolName: 'SSGITS - Maninagar',
    profileImageUrl: 'https://avatar.iran.liara.run/public/boy?username=harsh',
    grNo: 'T525',
    rollNo: '40',
    phoneNumber: '7874632208, 9727118158',
    aboutMe:
        '"Enthusiastic learner with a passion for robotics and mathematics."',
    familyInfo: FamilyInfo(
      fatherName: 'KEYUR',
      fatherOccupation: 'Business',
      fatherContact: '+91 7874632208',
      motherName: 'SEJAL',
      motherOccupation: 'Housewife',
      motherContact: '+91 9727118158',
      guardianName: '-',
      guardianOccupation: '-',
      guardianContact: '-',
      siblingName: '-',
      siblingClass: '-',
    ),
    basicInfo: BasicInfo(
      dob: '06/02/2021',
      gender: 'Male',
      bloodGroup: 'O+',
    ),
    communicationInfo: CommunicationInfo(
      address:
          '404, OMKAR APPARTMENT, DHANLAXMI SOCIETY, NR. SWAMINARAYAN MANDIR, MANINAGAR, AHMEDABAD - 38008',
      pincode: '380008',
      mobile: '7874632208',
      email: 'harsh.p@schoolmail.edu',
    ),
    academicInfo: AcademicInfo(
      penNumber: 'PEN-8890122',
      admissionId: 'ADM/2023/044',
      dateOfAdmission: '13/06/2024',
      rteStudent: 'No',
      previousSchool: '-',
      house: '-',
      classTeacher: 'Miss. Patel',
    ),
    documents: [
      DocumentInfo(name: 'Aadhar Card', number: '-'),
      DocumentInfo(name: 'Aadhar dise', number: '-'),
      DocumentInfo(name: 'Unique Id', number: '-'),
      DocumentInfo(name: 'Board Registration No', number: '-'),
    ],
    enquiryInfo: EnquiryInfo(
      dateOfEnquiry: '02/12/2023',
      dateOfRegistration: '02/12/2023',
      refPersonName: '-',
      remarks: '-',
    ),
  );

  @override
  List<Object?> get props => [
    name,
    studentId,
    className,
    profileImageUrl,
    aboutMe,
    schoolName,
    grNo,
    rollNo,
    phoneNumber,
    familyInfo,
    basicInfo,
    communicationInfo,
    academicInfo,
    documents,
    enquiryInfo,
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

class EnquiryInfo extends Equatable {
  final String dateOfEnquiry;
  final String dateOfRegistration;
  final String refPersonName;
  final String remarks;

  const EnquiryInfo({
    required this.dateOfEnquiry,
    required this.dateOfRegistration,
    required this.refPersonName,
    required this.remarks,
  });

  @override
  List<Object?> get props =>
      [dateOfEnquiry, dateOfRegistration, refPersonName, remarks];
}
