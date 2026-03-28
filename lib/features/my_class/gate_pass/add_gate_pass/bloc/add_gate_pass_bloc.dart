import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../student_notice/models/student_notice_recipient_model.dart';
import 'add_gate_pass_event.dart';
import 'add_gate_pass_state.dart';

class AddGatePassBloc extends Bloc<AddGatePassEvent, AddGatePassState> {
  AddGatePassBloc() : super(AddGatePassState(date: DateTime.now())) {
    on<SelectClassEvent>(_onSelectClass);
    on<SelectSectionEvent>(_onSelectSection);
    on<SelectDateEvent>(_onSelectDate);
    on<SelectTimeEvent>(_onSelectTime);
    on<SelectPickupTypeEvent>(_onSelectPickupType);
    on<UpdateReasonEvent>(_onUpdateReason);
    on<LoadStudentsEvent>(_onLoadStudents);
    on<SearchStudentsEvent>(_onSearchStudents);
    on<SelectStudentEvent>(_onSelectStudent);
    on<SubmitGatePassEvent>(_onSubmitGatePass);
  }

  void _onSelectClass(SelectClassEvent event, Emitter<AddGatePassState> emit) {
    emit(state.copyWith(selectedClass: event.className));
  }

  void _onSelectSection(
    SelectSectionEvent event,
    Emitter<AddGatePassState> emit,
  ) {
    emit(state.copyWith(section: event.section));
  }

  void _onSelectDate(SelectDateEvent event, Emitter<AddGatePassState> emit) {
    emit(state.copyWith(date: event.date));
  }

  void _onSelectTime(SelectTimeEvent event, Emitter<AddGatePassState> emit) {
    emit(state.copyWith(time: event.time));
  }

  void _onSelectPickupType(
    SelectPickupTypeEvent event,
    Emitter<AddGatePassState> emit,
  ) {
    emit(state.copyWith(pickupType: event.type));
  }

  void _onUpdateReason(
    UpdateReasonEvent event,
    Emitter<AddGatePassState> emit,
  ) {
    emit(state.copyWith(reason: event.reason, clearError: true));
  }

  Future<void> _onLoadStudents(
    LoadStudentsEvent event,
    Emitter<AddGatePassState> emit,
  ) async {
    emit(state.copyWith(isLoadingStudents: true));
    try {
      await Future.delayed(const Duration(milliseconds: 600)); // Mock delay
      final mockStudents = List.generate(
        15,
        (i) => StudentNoticeRecipientModel(
          id: 'S00${i + 1}',
          name: 'Student Name ${i + 1}',
          rollNo: '${100 + i}',
          className: state.selectedClass ?? '',
        ),
      );
      emit(
        state.copyWith(
          isLoadingStudents: false,
          allStudents: mockStudents,
          filteredStudents: mockStudents,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingStudents: false,
          error: 'Failed to load students',
        ),
      );
    }
  }

  void _onSearchStudents(
    SearchStudentsEvent event,
    Emitter<AddGatePassState> emit,
  ) {
    final query = event.query.toLowerCase();
    if (query.isEmpty) {
      emit(
        state.copyWith(searchQuery: query, filteredStudents: state.allStudents),
      );
      return;
    }
    final filtered = state.allStudents.where((student) {
      return student.name.toLowerCase().contains(query) ||
          student.rollNo.contains(query);
    }).toList();
    emit(state.copyWith(searchQuery: query, filteredStudents: filtered));
  }

  void _onSelectStudent(
    SelectStudentEvent event,
    Emitter<AddGatePassState> emit,
  ) {
    emit(state.copyWith(selectedStudentId: event.studentId));
  }

  Future<void> _onSubmitGatePass(
    SubmitGatePassEvent event,
    Emitter<AddGatePassState> emit,
  ) async {
    emit(state.copyWith(isSubmitting: true, clearError: true));
    try {
      // Simulate network request
      await Future.delayed(const Duration(milliseconds: 1000));
      emit(state.copyWith(isSubmitting: false, submitSuccess: true));
    } catch (e) {
      emit(
        state.copyWith(
          isSubmitting: false,
          error: 'Failed to submit gate pass. Please try again.',
        ),
      );
    }
  }
}
