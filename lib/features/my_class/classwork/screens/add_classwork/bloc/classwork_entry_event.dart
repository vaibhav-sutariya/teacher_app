import 'package:equatable/equatable.dart';

abstract class ClassworkEntryEvent extends Equatable {
  const ClassworkEntryEvent();

  @override
  List<Object?> get props => [];
}

class ClassworkContentChanged extends ClassworkEntryEvent {
  final String content;
  const ClassworkContentChanged(this.content);

  @override
  List<Object?> get props => [content];
}

class SubmitClassworkEvent extends ClassworkEntryEvent {}
