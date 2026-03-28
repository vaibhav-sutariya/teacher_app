import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/student_photo_class_model.dart';

part 'student_photo_upload_event.dart';
part 'student_photo_upload_state.dart';

class StudentPhotoUploadBloc
    extends Bloc<StudentPhotoUploadEvent, StudentPhotoUploadState> {
  StudentPhotoUploadBloc() : super(const StudentPhotoUploadState()) {
    on<LoadStudentPhotoClasses>(_onLoadClasses);
  }

  void _onLoadClasses(
      LoadStudentPhotoClasses event, Emitter<StudentPhotoUploadState> emit) async {
    emit(state.copyWith(status: StudentPhotoUploadStatus.loading));
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      final mockClasses = [
        const StudentPhotoClassModel(className: 'LITTLE CHAMPS - JAL'),
        const StudentPhotoClassModel(className: 'LITTLE CHAMPS - VAYU'),
        const StudentPhotoClassModel(className: 'LITTLE CHAMPS - AAKASH'),
        const StudentPhotoClassModel(className: 'LITTLE CHAMPS - PRITHVI'),
        const StudentPhotoClassModel(className: 'LITTLE CHAMPS - TEJ'),
        const StudentPhotoClassModel(className: 'JR.KG - JAL'),
        const StudentPhotoClassModel(className: 'JR.KG - VAYU'),
        const StudentPhotoClassModel(className: 'JR.KG - AAKASH'),
        const StudentPhotoClassModel(className: 'JR.KG - PRITHVI'),
        const StudentPhotoClassModel(className: 'SR.KG - JAL'),
        const StudentPhotoClassModel(className: 'SR.KG - VAYU'),
        const StudentPhotoClassModel(className: 'SR.KG - AAKASH'),
        const StudentPhotoClassModel(className: 'SR.KG - PRITHVI'),
        const StudentPhotoClassModel(className: '1ST - JAL'),
        const StudentPhotoClassModel(className: '1ST - VAYU'),
        const StudentPhotoClassModel(className: '1ST - AAKASH'),
        const StudentPhotoClassModel(className: '1ST - PRITHVI'),
      ];

      emit(state.copyWith(
        status: StudentPhotoUploadStatus.loaded,
        classes: mockClasses,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: StudentPhotoUploadStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
