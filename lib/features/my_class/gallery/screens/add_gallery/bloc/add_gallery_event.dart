import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

abstract class AddGalleryEvent extends Equatable {
  const AddGalleryEvent();

  @override
  List<Object?> get props => [];
}

class TitleChanged extends AddGalleryEvent {
  final String title;
  const TitleChanged(this.title);

  @override
  List<Object?> get props => [title];
}

class ImagesSelected extends AddGalleryEvent {
  final List<XFile> images;
  const ImagesSelected(this.images);

  @override
  List<Object?> get props => [images];
}

class ImageRemoved extends AddGalleryEvent {
  final int index;
  const ImageRemoved(this.index);

  @override
  List<Object?> get props => [index];
}

class SubmitGallery extends AddGalleryEvent {}
