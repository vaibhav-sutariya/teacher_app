part of 'parent_photo_bloc.dart';

enum ParentPhotoStatus { initial, loading, loaded, error }

class ParentPhotoState extends Equatable {
  final ParentPhotoStatus status;
  final List<ParentPhotoClassModel> classes;
  final String? errorMessage;

  const ParentPhotoState({
    this.status = ParentPhotoStatus.initial,
    this.classes = const [],
    this.errorMessage,
  });

  ParentPhotoState copyWith({
    ParentPhotoStatus? status,
    List<ParentPhotoClassModel>? classes,
    String? errorMessage,
  }) {
    return ParentPhotoState(
      status: status ?? this.status,
      classes: classes ?? this.classes,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, classes, errorMessage];
}
