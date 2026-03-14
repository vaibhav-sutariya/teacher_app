import 'package:equatable/equatable.dart';
import '../../models/concern_model.dart';
import 'package:image_picker/image_picker.dart';

abstract class ResolveConcernEvent extends Equatable {
  const ResolveConcernEvent();

  @override
  List<Object?> get props => [];
}

class StatusChanged extends ResolveConcernEvent {
  final ConcernStatus status;
  const StatusChanged(this.status);

  @override
  List<Object?> get props => [status];
}

class CommentChanged extends ResolveConcernEvent {
  final String comment;
  const CommentChanged(this.comment);

  @override
  List<Object?> get props => [comment];
}

class ImagesAdded extends ResolveConcernEvent {
  final List<XFile> images;
  const ImagesAdded(this.images);

  @override
  List<Object?> get props => [images];
}

class ImageRemoved extends ResolveConcernEvent {
  final int index;
  const ImageRemoved(this.index);

  @override
  List<Object?> get props => [index];
}

class SubmitResolution extends ResolveConcernEvent {
  final String concernId;
  const SubmitResolution(this.concernId);

  @override
  List<Object?> get props => [concernId];
}
