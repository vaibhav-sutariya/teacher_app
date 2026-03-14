import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'add_gallery_event.dart';
import 'add_gallery_state.dart';

class AddGalleryBloc extends Bloc<AddGalleryEvent, AddGalleryState> {
  AddGalleryBloc() : super(const AddGalleryState()) {
    on<TitleChanged>(_onTitleChanged);
    on<ImagesSelected>(_onImagesSelected);
    on<ImageRemoved>(_onImageRemoved);
    on<SubmitGallery>(_onSubmitGallery);
  }

  void _onTitleChanged(TitleChanged event, Emitter<AddGalleryState> emit) {
    emit(state.copyWith(title: event.title, isSuccess: false));
  }

  void _onImagesSelected(ImagesSelected event, Emitter<AddGalleryState> emit) {
    if (state.images.length >= 40) {
      emit(
        state.copyWith(error: 'Maximum 40 photos allowed', isSuccess: false),
      );
      return;
    }

    final remainingSlots = 40 - state.images.length;
    final imagesToAdd = event.images.take(remainingSlots).toList();

    if (imagesToAdd.length < event.images.length) {
      emit(
        state.copyWith(
          images: List<XFile>.from(state.images)..addAll(imagesToAdd),
          error: 'Only 40 photos allowed. Truncated extra photos.',
          isSuccess: false,
        ),
      );
    } else {
      final updatedImages = List<XFile>.from(state.images)
        ..addAll(event.images);
      emit(
        state.copyWith(images: updatedImages, isSuccess: false, error: null),
      );
    }
  }

  void _onImageRemoved(ImageRemoved event, Emitter<AddGalleryState> emit) {
    final updatedImages = List<XFile>.from(state.images)..removeAt(event.index);
    emit(state.copyWith(images: updatedImages, isSuccess: false));
  }

  Future<void> _onSubmitGallery(
    SubmitGallery event,
    Emitter<AddGalleryState> emit,
  ) async {
    if (!state.isFormValid) return;

    emit(state.copyWith(isLoading: true, error: null));

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // In a real app, we would upload images and send the title to the server

      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Failed to upload gallery: ${e.toString()}',
        ),
      );
    }
  }
}
