import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/remarks_student_model.dart';
import 'remarks_entry_event.dart';
import 'remarks_entry_state.dart';

class RemarksEntryBloc extends Bloc<RemarksEntryEvent, RemarksEntryState> {
  RemarksEntryBloc() : super(RemarksEntryState.initial()) {
    on<SelectClassEvent>(
      (event, emit) => emit(state.copyWith(selectedClass: event.selectedClass)),
    );
    on<SelectSectionEvent>(
      (event, emit) => emit(state.copyWith(section: event.section)),
    );
    on<SelectDateEvent>(
      (event, emit) => emit(state.copyWith(date: event.date)),
    );
    on<SelectCategoryEvent>(
      (event, emit) => emit(state.copyWith(category: event.category)),
    );
    on<SelectRemarkNameEvent>(
      (event, emit) => emit(state.copyWith(remarkName: event.remarkName)),
    );
    on<SelectRemarkTypeEvent>(
      (event, emit) => emit(state.copyWith(remarkType: event.remarkType)),
    );
    on<UpdateNoteEvent>(
      (event, emit) => emit(state.copyWith(note: event.note)),
    );

    on<LoadStudentsEvent>(_onLoadStudents);
    on<SearchStudentsEvent>(_onSearchStudents);
    on<ToggleStudentSelectionEvent>(_onToggleSelection);
    on<ToggleSelectAllEvent>(_onToggleSelectAll);
    on<SubmitFormEvent>(_onSubmit);
  }

  void _onLoadStudents(
    LoadStudentsEvent event,
    Emitter<RemarksEntryState> emit,
  ) {
    emit(state.copyWith(isLoadingStudents: true));

    // Mock Data based on the image provided
    final mockStudents = [
      const RemarksStudentModel(
        id: '1',
        name: 'Aditi Sharma',
        rollNo: '101',
        className: 'Class 10-A',
      ),
      const RemarksStudentModel(
        id: '2',
        name: 'Arjun Mehra',
        rollNo: '102',
        className: 'Class 10-A',
      ),
      const RemarksStudentModel(
        id: '3',
        name: 'Deepika Singh',
        rollNo: '103',
        className: 'Class 10-A',
      ),
      const RemarksStudentModel(
        id: '4',
        name: 'Ishaan Verma',
        rollNo: '104',
        className: 'Class 10-A',
      ),
      const RemarksStudentModel(
        id: '5',
        name: 'Karan Joshi',
        rollNo: '105',
        className: 'Class 10-A',
      ),
      const RemarksStudentModel(
        id: '6',
        name: 'Meera Iyer',
        rollNo: '106',
        className: 'Class 10-A',
      ),
      const RemarksStudentModel(
        id: '7',
        name: 'Nikhil Reddy',
        rollNo: '107',
        className: 'Class 10-A',
      ),
    ];

    emit(
      state.copyWith(
        isLoadingStudents: false,
        allStudents: mockStudents,
        filteredStudents: mockStudents,
      ),
    );
  }

  void _onSearchStudents(
    SearchStudentsEvent event,
    Emitter<RemarksEntryState> emit,
  ) {
    final query = event.query.toLowerCase();

    if (query.isEmpty) {
      emit(
        state.copyWith(searchQuery: query, filteredStudents: state.allStudents),
      );
    } else {
      final filtered = state.allStudents.where((student) {
        return student.name.toLowerCase().contains(query);
      }).toList();

      emit(state.copyWith(searchQuery: query, filteredStudents: filtered));
    }
  }

  void _onToggleSelection(
    ToggleStudentSelectionEvent event,
    Emitter<RemarksEntryState> emit,
  ) {
    final currentSelection = Set<String>.from(state.selectedStudentIds);
    if (currentSelection.contains(event.studentId)) {
      currentSelection.remove(event.studentId);
    } else {
      currentSelection.add(event.studentId);
    }
    emit(state.copyWith(selectedStudentIds: currentSelection));
  }

  void _onToggleSelectAll(
    ToggleSelectAllEvent event,
    Emitter<RemarksEntryState> emit,
  ) {
    final filteredIds = state.filteredStudents.map((e) => e.id).toSet();
    final bool areAllFilteredSelected =
        filteredIds.isNotEmpty &&
        filteredIds.every((id) => state.selectedStudentIds.contains(id));

    final currentSelection = Set<String>.from(state.selectedStudentIds);

    if (areAllFilteredSelected) {
      currentSelection.removeAll(filteredIds);
    } else {
      currentSelection.addAll(filteredIds);
    }

    emit(state.copyWith(selectedStudentIds: currentSelection));
  }

  Future<void> _onSubmit(
    SubmitFormEvent event,
    Emitter<RemarksEntryState> emit,
  ) async {
    emit(state.copyWith(isSubmitting: true));

    // Simulate API call using all form data and student IDs
    await Future.delayed(const Duration(milliseconds: 1500));

    emit(state.copyWith(isSubmitting: false, submitSuccess: true));
  }
}
