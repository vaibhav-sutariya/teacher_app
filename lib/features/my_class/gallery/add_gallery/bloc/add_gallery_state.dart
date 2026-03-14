import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class AddGalleryState extends Equatable {
  final String title;
  final List<XFile> images;
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  const AddGalleryState({
    this.title = '',
    this.images = const [],
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  bool get isFormValid => title.isNotEmpty && images.isNotEmpty;

  AddGalleryState copyWith({
    String? title,
    List<XFile>? images,
    bool? isLoading,
    String? error,
    bool? isSuccess,
  }) {
    return AddGalleryState(
      title: title ?? this.title,
      images: images ?? this.images,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [title, images, isLoading, error, isSuccess];
}
