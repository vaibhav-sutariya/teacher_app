import 'package:equatable/equatable.dart';

abstract class AddStudentNoticeEvent extends Equatable {
  const AddStudentNoticeEvent();

  @override
  List<Object?> get props => [];
}

class SelectClassEvent extends AddStudentNoticeEvent {
  final String className;
  const SelectClassEvent(this.className);

  @override
  List<Object?> get props => [className];
}

class SelectSectionEvent extends AddStudentNoticeEvent {
  final String section;
  const SelectSectionEvent(this.section);

  @override
  List<Object?> get props => [section];
}

class SelectDateEvent extends AddStudentNoticeEvent {
  final DateTime date;
  const SelectDateEvent(this.date);

  @override
  List<Object?> get props => [date];
}

class UpdateTitleEvent extends AddStudentNoticeEvent {
  final String title;
  const UpdateTitleEvent(this.title);

  @override
  List<Object?> get props => [title];
}

class UpdateContentEvent extends AddStudentNoticeEvent {
  final String content;
  const UpdateContentEvent(this.content);

  @override
  List<Object?> get props => [content];
}

class AttachImageEvent extends AddStudentNoticeEvent {
  final String imagePath;
  const AttachImageEvent(this.imagePath);

  @override
  List<Object?> get props => [imagePath];
}

class AttachDocumentEvent extends AddStudentNoticeEvent {
  final String documentPath;
  const AttachDocumentEvent(this.documentPath);

  @override
  List<Object?> get props => [documentPath];
}

class LoadStudentsEvent extends AddStudentNoticeEvent {}

class SearchStudentsEvent extends AddStudentNoticeEvent {
  final String query;
  const SearchStudentsEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class ToggleStudentSelectionEvent extends AddStudentNoticeEvent {
  final String studentId;
  const ToggleStudentSelectionEvent(this.studentId);

  @override
  List<Object?> get props => [studentId];
}

class ToggleSelectAllEvent extends AddStudentNoticeEvent {}

class SubmitNoticeEvent extends AddStudentNoticeEvent {}
