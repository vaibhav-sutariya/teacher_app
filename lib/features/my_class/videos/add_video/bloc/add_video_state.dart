import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class AddVideoState extends Equatable {
  final String title;
  final List<XFile> videos;
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  const AddVideoState({
    this.title = '',
    this.videos = const [],
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  bool get isFormValid => title.isNotEmpty && videos.isNotEmpty;

  AddVideoState copyWith({
    String? title,
    List<XFile>? videos,
    bool? isLoading,
    String? error,
    bool? isSuccess,
  }) {
    return AddVideoState(
      title: title ?? this.title,
      videos: videos ?? this.videos,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [title, videos, isLoading, error, isSuccess];
}
