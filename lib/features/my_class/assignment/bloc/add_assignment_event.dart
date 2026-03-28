part of 'add_assignment_bloc.dart';

abstract class AddAssignmentEvent extends Equatable {
  const AddAssignmentEvent();

  @override
  List<Object?> get props => [];
}

class UpdateClassEvent extends AddAssignmentEvent {
  final String selectedClass;
  const UpdateClassEvent(this.selectedClass);

  @override
  List<Object?> get props => [selectedClass];
}

class UpdateSectionEvent extends AddAssignmentEvent {
  final String section;
  const UpdateSectionEvent(this.section);

  @override
  List<Object?> get props => [section];
}

class UpdateSubjectEvent extends AddAssignmentEvent {
  final String subject;
  const UpdateSubjectEvent(this.subject);

  @override
  List<Object?> get props => [subject];
}

class UpdateLessonEvent extends AddAssignmentEvent {
  final String lesson;
  const UpdateLessonEvent(this.lesson);

  @override
  List<Object?> get props => [lesson];
}

class UpdateTopicEvent extends AddAssignmentEvent {
  final String topic;
  const UpdateTopicEvent(this.topic);

  @override
  List<Object?> get props => [topic];
}

class UpdateAttachmentTypeEvent extends AddAssignmentEvent {
  final AttachmentType attachmentType;
  const UpdateAttachmentTypeEvent(this.attachmentType);

  @override
  List<Object?> get props => [attachmentType];
}

class UpdateDescriptionEvent extends AddAssignmentEvent {
  final String description;
  const UpdateDescriptionEvent(this.description);

  @override
  List<Object?> get props => [description];
}

class ToggleSmsEvent extends AddAssignmentEvent {
  final bool isSmsEnabled;
  const ToggleSmsEvent(this.isSmsEnabled);

  @override
  List<Object?> get props => [isSmsEnabled];
}

class SubmitAssignmentEvent extends AddAssignmentEvent {}
