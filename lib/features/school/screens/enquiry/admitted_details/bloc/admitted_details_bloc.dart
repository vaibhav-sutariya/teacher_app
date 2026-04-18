import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../models/enquiry_student_model.dart';

part 'admitted_details_event.dart';
part 'admitted_details_state.dart';

class AdmittedDetailsBloc
    extends Bloc<AdmittedDetailsEvent, AdmittedDetailsState> {
  AdmittedDetailsBloc() : super(AdmittedDetailsInitial()) {
    on<LoadAdmittedDetails>(_onLoadDetails);
  }

  Future<void> _onLoadDetails(
    LoadAdmittedDetails event,
    Emitter<AdmittedDetailsState> emit,
  ) async {
    emit(AdmittedDetailsLoading());
    try {
      // Mock data generation for the specific date
      await Future.delayed(const Duration(milliseconds: 600));
      final students = _generateMockStudents(event.date);
      emit(AdmittedDetailsLoaded(students: students));
    } catch (e) {
      emit(AdmittedDetailsError(message: e.toString()));
    }
  }

  List<EnquiryStudentModel> _generateMockStudents(DateTime date) {
    return [
      EnquiryStudentModel(
        name: 'AMIT KUMAR',
        fatherName: 'MR. RAJESH KUMAR',
        className: 'Class 10',
        gender: 'Male',
        status: 'ADMITTED',
        date: date,
        phone: '9876543210',
      ),
      EnquiryStudentModel(
        name: 'PRIYA SHARMA',
        fatherName: 'MR. ANIL SHARMA',
        className: 'Class 8',
        gender: 'Female',
        status: 'ENQUIRY',
        date: date,
        phone: '9123456789',
      ),
      EnquiryStudentModel(
        name: 'SNEHA VERMA',
        fatherName: 'MR. VIJAY VERMA',
        className: 'Class 5',
        gender: 'Female',
        status: 'REGISTRATION',
        date: date,
        phone: '9988776655',
      ),
      EnquiryStudentModel(
        name: 'ROHAN SINGH',
        fatherName: 'MR. SURENDRA SINGH',
        className: 'Class 12',
        gender: 'Male',
        status: 'ADMITTED',
        date: date,
        phone: '8877665544',
      ),
    ];
  }
}
