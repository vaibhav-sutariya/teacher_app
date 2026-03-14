import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

abstract class AddVideoEvent extends Equatable {
  const AddVideoEvent();

  @override
  List<Object?> get props => [];
}

class TitleChanged extends AddVideoEvent {
  final String title;
  const TitleChanged(this.title);

  @override
  List<Object?> get props => [title];
}

class VideosSelected extends AddVideoEvent {
  final List<XFile> videos;
  const VideosSelected(this.videos);

  @override
  List<Object?> get props => [videos];
}

class VideoRemoved extends AddVideoEvent {
  final int index;
  const VideoRemoved(this.index);

  @override
  List<Object?> get props => [index];
}

class SubmitVideo extends AddVideoEvent {}
