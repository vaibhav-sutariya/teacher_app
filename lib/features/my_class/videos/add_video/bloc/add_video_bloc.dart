import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'add_video_event.dart';
import 'add_video_state.dart';

class AddVideoBloc extends Bloc<AddVideoEvent, AddVideoState> {
  AddVideoBloc() : super(const AddVideoState()) {
    on<TitleChanged>(_onTitleChanged);
    on<VideosSelected>(_onVideosSelected);
    on<VideoRemoved>(_onVideoRemoved);
    on<SubmitVideo>(_onSubmitVideo);
  }

  void _onTitleChanged(TitleChanged event, Emitter<AddVideoState> emit) {
    emit(state.copyWith(title: event.title, isSuccess: false));
  }

  void _onVideosSelected(VideosSelected event, Emitter<AddVideoState> emit) {
    if (state.videos.length >= 10) {
      emit(
        state.copyWith(error: 'Maximum 10 videos allowed', isSuccess: false),
      );
      return;
    }

    final updatedVideos = List<XFile>.from(state.videos)..addAll(event.videos);

    if (updatedVideos.length > 10) {
      emit(
        state.copyWith(
          videos: updatedVideos.take(10).toList(),
          error: 'Only 10 videos allowed.',
          isSuccess: false,
        ),
      );
    } else {
      emit(
        state.copyWith(videos: updatedVideos, isSuccess: false, error: null),
      );
    }
  }

  void _onVideoRemoved(VideoRemoved event, Emitter<AddVideoState> emit) {
    final updatedVideos = List<XFile>.from(state.videos)..removeAt(event.index);
    emit(state.copyWith(videos: updatedVideos, isSuccess: false));
  }

  Future<void> _onSubmitVideo(
    SubmitVideo event,
    Emitter<AddVideoState> emit,
  ) async {
    if (!state.isFormValid) return;

    emit(state.copyWith(isLoading: true, error: null));

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Failed to upload videos: ${e.toString()}',
        ),
      );
    }
  }
}
