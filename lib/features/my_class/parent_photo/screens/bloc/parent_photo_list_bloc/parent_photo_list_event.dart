part of 'parent_photo_list_bloc.dart';

abstract class ParentPhotoListEvent extends Equatable {
  const ParentPhotoListEvent();

  @override
  List<Object?> get props => [];
}

class LoadParents extends ParentPhotoListEvent {
  final String className;
  const LoadParents(this.className);

  @override
  List<Object?> get props => [className];
}

class SearchParents extends ParentPhotoListEvent {
  final String query;
  const SearchParents(this.query);

  @override
  List<Object?> get props => [query];
}

class UpdateParentPhoto extends ParentPhotoListEvent {
  final String parentId;
  final String status; // 'uploaded'
  const UpdateParentPhoto({required this.parentId, required this.status});

  @override
  List<Object?> get props => [parentId, status];
}
