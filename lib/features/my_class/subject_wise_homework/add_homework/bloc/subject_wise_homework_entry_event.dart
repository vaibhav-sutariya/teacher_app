import 'package:equatable/equatable.dart';

abstract class SubjectWiseHomeworkEntryEvent extends Equatable {
  const SubjectWiseHomeworkEntryEvent();

  @override
  List<Object?> get props => [];
}

class HomeworkContentChanged extends SubjectWiseHomeworkEntryEvent {
  final String content;
  const HomeworkContentChanged(this.content);

  @override
  List<Object?> get props => [content];
}

class SubmissionDateChanged extends SubjectWiseHomeworkEntryEvent {
  final DateTime date;
  const SubmissionDateChanged(this.date);

  @override
  List<Object?> get props => [date];
}

class ImageAttachmentAdded extends SubjectWiseHomeworkEntryEvent {
  final String path;
  const ImageAttachmentAdded(this.path);

  @override
  List<Object?> get props => [path];
}

class DocumentAttachmentAdded extends SubjectWiseHomeworkEntryEvent {
  final String path;
  const DocumentAttachmentAdded(this.path);

  @override
  List<Object?> get props => [path];
}

class SubmitHomeworkEvent extends SubjectWiseHomeworkEntryEvent {}
