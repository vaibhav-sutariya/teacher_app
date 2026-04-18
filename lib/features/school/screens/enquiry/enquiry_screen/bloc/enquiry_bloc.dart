import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../models/enquiry_model.dart';

part 'enquiry_event.dart';
part 'enquiry_state.dart';

class EnquiryBloc extends Bloc<EnquiryEvent, EnquiryState> {
  EnquiryBloc() : super(EnquiryInitial(selectedMonth: DateTime.now())) {
    on<LoadEnquiries>(_onLoadEnquiries);
    on<ChangeEnquiryMonth>(_onChangeMonth);
  }

  Future<void> _onLoadEnquiries(
    LoadEnquiries event,
    Emitter<EnquiryState> emit,
  ) async {
    emit(EnquiryLoading(selectedMonth: state.selectedMonth));
    try {
      // Mock data generation
      await Future.delayed(const Duration(milliseconds: 500));
      final enquiries = _generateMockEnquiries(state.selectedMonth);
      emit(
        EnquiryLoaded(selectedMonth: state.selectedMonth, enquiries: enquiries),
      );
    } catch (e) {
      emit(
        EnquiryError(selectedMonth: state.selectedMonth, message: e.toString()),
      );
    }
  }

  void _onChangeMonth(ChangeEnquiryMonth event, Emitter<EnquiryState> emit) {
    emit(state.copyWith(selectedMonth: event.newMonth));
    add(LoadEnquiries());
  }

  List<EnquiryModel> _generateMockEnquiries(DateTime month) {
    // Generate some mock data for the selected month
    return [
      EnquiryModel(
        date: DateTime(month.year, month.month, 24),
        admittedCount: 1,
        enquiryCount: 0,
        registrationCount: 0,
      ),
      EnquiryModel(
        date: DateTime(month.year, month.month, 21),
        admittedCount: 1,
        enquiryCount: 0,
        registrationCount: 1,
      ),
      EnquiryModel(
        date: DateTime(month.year, month.month, 19),
        admittedCount: 0,
        enquiryCount: 2,
        registrationCount: 1,
      ),
      EnquiryModel(
        date: DateTime(month.year, month.month, 17),
        admittedCount: 1,
        enquiryCount: 0,
        registrationCount: 0,
      ),
    ];
  }
}
