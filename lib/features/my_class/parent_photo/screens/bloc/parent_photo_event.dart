part of 'parent_photo_bloc.dart';

abstract class ParentPhotoEvent extends Equatable {
  const ParentPhotoEvent();

  @override
  List<Object> get props => [];
}

class LoadParentPhoto extends ParentPhotoEvent {}
