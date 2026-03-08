part of 'parent_photo_bloc.dart';

abstract class ParentPhotoState extends Equatable {
  const ParentPhotoState();

  @override
  List<Object> get props => [];
}

class ParentPhotoInitial extends ParentPhotoState {}

class ParentPhotoLoading extends ParentPhotoState {}

class ParentPhotoLoaded extends ParentPhotoState {}

class ParentPhotoError extends ParentPhotoState {
  final String message;
  const ParentPhotoError(this.message);
  @override
  List<Object> get props => [message];
}
