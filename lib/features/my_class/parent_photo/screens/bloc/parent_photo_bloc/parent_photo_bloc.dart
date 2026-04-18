import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../models/parent_photo_class_model.dart';

part 'parent_photo_event.dart';
part 'parent_photo_state.dart';

class ParentPhotoBloc extends Bloc<ParentPhotoEvent, ParentPhotoState> {
  ParentPhotoBloc() : super(const ParentPhotoState()) {
    on<LoadParentPhotoClasses>(_onLoadClasses);
  }

  void _onLoadClasses(
    LoadParentPhotoClasses event,
    Emitter<ParentPhotoState> emit,
  ) async {
    emit(state.copyWith(status: ParentPhotoStatus.loading));
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      final mockClasses = [
        const ParentPhotoClassModel(className: 'LITTLE CHAMPS - JAL'),
        const ParentPhotoClassModel(className: 'LITTLE CHAMPS - VAYU'),
        const ParentPhotoClassModel(className: 'JR.KG - JAL'),
        const ParentPhotoClassModel(className: 'JR.KG - VAYU'),
        const ParentPhotoClassModel(className: 'SR.KG - JAL'),
        const ParentPhotoClassModel(className: 'SR.KG - VAYU'),
        const ParentPhotoClassModel(className: '1ST - JAL'),
        const ParentPhotoClassModel(className: '1ST - VAYU'),
      ];

      emit(
        state.copyWith(status: ParentPhotoStatus.loaded, classes: mockClasses),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ParentPhotoStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
