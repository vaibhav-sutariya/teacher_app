import 'package:equatable/equatable.dart';

import '../models/student_profile_model.dart';

abstract class StudentProfileState extends Equatable {
  const StudentProfileState();

  @override
  List<Object?> get props => [];
}

class StudentProfileLoading extends StudentProfileState {}

class StudentProfileLoaded extends StudentProfileState {
  final StudentProfileModel profile;

  const StudentProfileLoaded(this.profile);

  @override
  List<Object?> get props => [profile];
}

class StudentProfileError extends StudentProfileState {
  final String message;

  const StudentProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
