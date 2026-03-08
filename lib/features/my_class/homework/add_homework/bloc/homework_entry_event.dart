import 'package:equatable/equatable.dart';

abstract class HomeworkEntryEvent extends Equatable {
  const HomeworkEntryEvent();

  @override
  List<Object?> get props => [];
}

class HomeworkEntryContentChanged extends HomeworkEntryEvent {
  final String content;
  const HomeworkEntryContentChanged(this.content);

  @override
  List<Object?> get props => [content];
}

class HomeworkEntryImageAdded extends HomeworkEntryEvent {
  final String path;
  const HomeworkEntryImageAdded(this.path);

  @override
  List<Object?> get props => [path];
}

class HomeworkEntryDocumentAdded extends HomeworkEntryEvent {
  final String path;
  const HomeworkEntryDocumentAdded(this.path);

  @override
  List<Object?> get props => [path];
}

class HomeworkEntrySubmitted extends HomeworkEntryEvent {}
