import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/admission_class_model.dart';

part 'admission_details_event.dart';
part 'admission_details_state.dart';

class AdmissionDetailsBloc extends Bloc<AdmissionDetailsEvent, AdmissionDetailsState> {
  AdmissionDetailsBloc() : super(const AdmissionDetailsState()) {
    on<LoadDateAdmissions>(_onLoadDateAdmissions);
  }

  void _onLoadDateAdmissions(
      LoadDateAdmissions event, Emitter<AdmissionDetailsState> emit) async {
    emit(state.copyWith(status: AdmissionDetailsStatus.loading, selectedDate: event.date));
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Mock data based on the user's image
      final mockClassAdmissions = [
        const AdmissionClassModel(className: '9th - JAL', count: 52),
        const AdmissionClassModel(className: '9th - VAYU', count: 51),
        const AdmissionClassModel(className: '11th-COMMERCE - JAL', count: 32),
        const AdmissionClassModel(className: '11th-SCIENCE - JAL', count: 23),
      ];

      final total = mockClassAdmissions.fold<int>(0, (sum, item) => sum + item.count);

      emit(state.copyWith(
        status: AdmissionDetailsStatus.loaded,
        classAdmissions: mockClassAdmissions,
        totalCount: total,
      ));
    } catch (e) {
      emit(state.copyWith(
          status: AdmissionDetailsStatus.error, errorMessage: e.toString()));
    }
  }
}
