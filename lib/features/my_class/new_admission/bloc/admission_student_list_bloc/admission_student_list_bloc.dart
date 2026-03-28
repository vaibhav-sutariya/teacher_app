import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/admission_student_model.dart';

part 'admission_student_list_event.dart';
part 'admission_student_list_state.dart';

class AdmissionStudentListBloc
    extends Bloc<AdmissionStudentListEvent, AdmissionStudentListState> {
  AdmissionStudentListBloc() : super(const AdmissionStudentListState()) {
    on<LoadClassAdmissions>(_onLoadClassAdmissions);
  }

  void _onLoadClassAdmissions(LoadClassAdmissions event,
      Emitter<AdmissionStudentListState> emit) async {
    emit(state.copyWith(
      status: AdmissionStudentListStatus.loading,
      className: event.className,
      date: event.date,
    ));
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Mock data based on the user's image
      final mockStudents = [
        const AdmissionStudentModel(
            rollNo: '9', grNo: '133', name: 'NAGAR YASHICA'),
        const AdmissionStudentModel(
            rollNo: '8', grNo: '156', name: 'MISHRA SAUMYA'),
        const AdmissionStudentModel(
            rollNo: '28', grNo: '155', name: 'SHARMA JAHNVI'),
        const AdmissionStudentModel(
            rollNo: '12', grNo: '139', name: 'PATEL AVAM'),
        const AdmissionStudentModel(
            rollNo: '13', grNo: '150', name: 'PATEL BHAKTI'),
        const AdmissionStudentModel(
            rollNo: '62', grNo: '147', name: 'TRIVEDI KRASHNA'),
        const AdmissionStudentModel(
            rollNo: '25', grNo: '141', name: 'SHAH MANUSHI'),
        const AdmissionStudentModel(
            rollNo: '6', grNo: '145', name: 'LAKHANI SANAYA'),
        const AdmissionStudentModel(
            rollNo: '39', grNo: '148', name: 'CHOKSI SHUBH ANKIT'),
        const AdmissionStudentModel(
            rollNo: '48', grNo: '190', name: 'PARMAR SWAPNIL'),
        const AdmissionStudentModel(
            rollNo: '38', grNo: '135', name: 'BRAHMBHATT VEDANT'),
        const AdmissionStudentModel(
            rollNo: '37', grNo: '146', name: 'BHAVSAR VYOM AKASH'),
      ];

      emit(state.copyWith(
        status: AdmissionStudentListStatus.loaded,
        students: mockStudents,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AdmissionStudentListStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
