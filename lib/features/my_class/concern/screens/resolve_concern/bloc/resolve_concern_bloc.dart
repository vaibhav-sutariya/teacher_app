import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../repository/concern_repository.dart';
import 'resolve_concern_event.dart';
import 'resolve_concern_state.dart';

class ResolveConcernBloc
    extends Bloc<ResolveConcernEvent, ResolveConcernState> {
  final ConcernRepository _concernRepository;

  ResolveConcernBloc({ConcernRepository? concernRepository})
    : _concernRepository = concernRepository ?? MockConcernRepository(),
      super(const ResolveConcernState()) {
    on<StatusChanged>(_onStatusChanged);
    on<CommentChanged>(_onCommentChanged);
    on<ImagesAdded>(_onImagesAdded);
    on<ImageRemoved>(_onImageRemoved);
    on<SubmitResolution>(_onSubmitResolution);
  }

  void _onStatusChanged(
    StatusChanged event,
    Emitter<ResolveConcernState> emit,
  ) {
    emit(state.copyWith(status: event.status, isSuccess: false));
  }

  void _onCommentChanged(
    CommentChanged event,
    Emitter<ResolveConcernState> emit,
  ) {
    emit(state.copyWith(comment: event.comment, isSuccess: false));
  }

  void _onImagesAdded(ImagesAdded event, Emitter<ResolveConcernState> emit) {
    if (state.proofImages.length >= 5) {
      emit(
        state.copyWith(
          error: 'Maximum 5 proof images allowed',
          isSuccess: false,
        ),
      );
      return;
    }

    final updatedImages = List<XFile>.from(state.proofImages)
      ..addAll(event.images);
    if (updatedImages.length > 5) {
      emit(
        state.copyWith(
          proofImages: updatedImages.take(5).toList(),
          error: 'Only 5 proof images allowed. Truncated extra images.',
          isSuccess: false,
        ),
      );
    } else {
      emit(
        state.copyWith(
          proofImages: updatedImages,
          isSuccess: false,
          error: null,
        ),
      );
    }
  }

  void _onImageRemoved(ImageRemoved event, Emitter<ResolveConcernState> emit) {
    final updatedImages = List<XFile>.from(state.proofImages)
      ..removeAt(event.index);
    emit(state.copyWith(proofImages: updatedImages, isSuccess: false));
  }

  Future<void> _onSubmitResolution(
    SubmitResolution event,
    Emitter<ResolveConcernState> emit,
  ) async {
    if (!state.isFormValid) return;

    emit(state.copyWith(isLoading: true, error: null));

    try {
      await _concernRepository.resolveConcern(
        concernId: event.concernId,
        status: state.status,
        resolution: state.comment,
        proofImages: state.proofImages.map((img) => img.path).toList(),
      );

      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Failed to resolve concern: ${e.toString()}',
        ),
      );
    }
  }
}
