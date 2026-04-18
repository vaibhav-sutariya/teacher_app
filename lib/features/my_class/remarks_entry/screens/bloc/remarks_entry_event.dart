import 'package:equatable/equatable.dart';

abstract class RemarksEntryEvent extends Equatable {
  const RemarksEntryEvent();

  @override
  List<Object?> get props => [];
}

// Form Events
class SelectClassEvent extends RemarksEntryEvent {
  final String selectedClass;
  const SelectClassEvent(this.selectedClass);

  @override
  List<Object?> get props => [selectedClass];
}

class SelectSectionEvent extends RemarksEntryEvent {
  final String section;
  const SelectSectionEvent(this.section);

  @override
  List<Object?> get props => [section];
}

class SelectDateEvent extends RemarksEntryEvent {
  final DateTime date;
  const SelectDateEvent(this.date);

  @override
  List<Object?> get props => [date];
}

class SelectCategoryEvent extends RemarksEntryEvent {
  final String category;
  const SelectCategoryEvent(this.category);

  @override
  List<Object?> get props => [category];
}

class SelectRemarkNameEvent extends RemarksEntryEvent {
  final String remarkName;
  const SelectRemarkNameEvent(this.remarkName);

  @override
  List<Object?> get props => [remarkName];
}

class SelectRemarkTypeEvent extends RemarksEntryEvent {
  final String remarkType;
  const SelectRemarkTypeEvent(this.remarkType);

  @override
  List<Object?> get props => [remarkType];
}

class UpdateNoteEvent extends RemarksEntryEvent {
  final String note;
  const UpdateNoteEvent(this.note);

  @override
  List<Object?> get props => [note];
}

// Student Selection Events
class LoadStudentsEvent extends RemarksEntryEvent {}

class SearchStudentsEvent extends RemarksEntryEvent {
  final String query;
  const SearchStudentsEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class ToggleStudentSelectionEvent extends RemarksEntryEvent {
  final String studentId;
  const ToggleStudentSelectionEvent(this.studentId);

  @override
  List<Object?> get props => [studentId];
}

class ToggleSelectAllEvent extends RemarksEntryEvent {}

// Final Submit
class SubmitFormEvent extends RemarksEntryEvent {}
