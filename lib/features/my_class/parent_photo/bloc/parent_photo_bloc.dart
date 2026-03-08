import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'parent_photo_event.dart';
part 'parent_photo_state.dart';

class ParentPhotoBloc extends Bloc<ParentPhotoEvent, ParentPhotoState> {
  ParentPhotoBloc() : super(ParentPhotoInitial()) {
    on<LoadParentPhoto>((event, emit) async {
      emit(ParentPhotoLoading());
      try {
        // Simulate network delay
        await Future.delayed(const Duration(seconds: 1));
        emit(ParentPhotoLoaded());
      } catch (e) {
        emit(ParentPhotoError(e.toString()));
      }
    });
  }
}
