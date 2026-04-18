import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/student_notice_repository.dart';
import '../../../models/student_notice_recipient_model.dart';
import 'add_student_notice_event.dart';
import 'add_student_notice_state.dart';

class AddStudentNoticeBloc
    extends Bloc<AddStudentNoticeEvent, AddStudentNoticeState> {
  final StudentNoticeRepository _repository;

  AddStudentNoticeBloc({StudentNoticeRepository? repository})
    : _repository = repository ?? StudentNoticeRepository(),
      super(AddStudentNoticeState.initial()) {
    on<SelectClassEvent>(_onSelectClass);
    on<SelectSectionEvent>(_onSelectSection);
    on<SelectDateEvent>(_onSelectDate);
    on<UpdateTitleEvent>(_onUpdateTitle);
    on<UpdateContentEvent>(_onUpdateContent);
    on<AttachImageEvent>(_onAttachImage);
    on<AttachDocumentEvent>(_onAttachDocument);

    // Student Selection related
    on<LoadStudentsEvent>(_onLoadStudents);
    on<SearchStudentsEvent>(_onSearchStudents);
    on<ToggleStudentSelectionEvent>(_onToggleStudentSelection);
    on<ToggleSelectAllEvent>(_onToggleSelectAll);

    // Submit
    on<SubmitNoticeEvent>(_onSubmitNotice);
  }

  void _onSelectClass(
    SelectClassEvent event,
    Emitter<AddStudentNoticeState> emit,
  ) {
    emit(state.copyWith(selectedClass: event.className));
  }

  void _onSelectSection(
    SelectSectionEvent event,
    Emitter<AddStudentNoticeState> emit,
  ) {
    emit(state.copyWith(section: event.section));
  }

  void _onSelectDate(
    SelectDateEvent event,
    Emitter<AddStudentNoticeState> emit,
  ) {
    emit(state.copyWith(date: event.date));
  }

  void _onUpdateTitle(
    UpdateTitleEvent event,
    Emitter<AddStudentNoticeState> emit,
  ) {
    emit(state.copyWith(title: event.title));
  }

  void _onUpdateContent(
    UpdateContentEvent event,
    Emitter<AddStudentNoticeState> emit,
  ) {
    emit(state.copyWith(content: event.content));
  }

  void _onAttachImage(
    AttachImageEvent event,
    Emitter<AddStudentNoticeState> emit,
  ) {
    emit(state.copyWith(imagePath: event.imagePath));
  }

  void _onAttachDocument(
    AttachDocumentEvent event,
    Emitter<AddStudentNoticeState> emit,
  ) {
    emit(state.copyWith(documentPath: event.documentPath));
  }

  Future<void> _onLoadStudents(
    LoadStudentsEvent event,
    Emitter<AddStudentNoticeState> emit,
  ) async {
    emit(state.copyWith(isLoadingStudents: true, error: null));
    try {
      // Mock loading students based on class and section
      await Future.delayed(const Duration(seconds: 1));
      final mockStudents = [
        StudentNoticeRecipientModel(
          id: '1',
          name: 'Aarav Patel',
          rollNo: '101',
          className: state.selectedClass ?? 'Class',
        ),
        StudentNoticeRecipientModel(
          id: '2',
          name: 'Isha Sharma',
          rollNo: '102',
          className: state.selectedClass ?? 'Class',
        ),
        StudentNoticeRecipientModel(
          id: '3',
          name: 'Rohan Gupta',
          rollNo: '103',
          className: state.selectedClass ?? 'Class',
        ),
        StudentNoticeRecipientModel(
          id: '4',
          name: 'Diya Verma',
          rollNo: '104',
          className: state.selectedClass ?? 'Class',
        ),
        StudentNoticeRecipientModel(
          id: '5',
          name: 'Vivaan Singh',
          rollNo: '105',
          className: state.selectedClass ?? 'Class',
        ),
      ];
      emit(
        state.copyWith(
          isLoadingStudents: false,
          allStudents: mockStudents,
          filteredStudents: mockStudents,
          selectedStudentIds: {}, // Reset selection on new load
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoadingStudents: false, error: e.toString()));
    }
  }

  void _onSearchStudents(
    SearchStudentsEvent event,
    Emitter<AddStudentNoticeState> emit,
  ) {
    final query = event.query.toLowerCase();
    final filtered = state.allStudents.where((student) {
      return student.name.toLowerCase().contains(query) ||
          student.rollNo.toLowerCase().contains(query);
    }).toList();

    emit(state.copyWith(searchQuery: query, filteredStudents: filtered));
  }

  void _onToggleStudentSelection(
    ToggleStudentSelectionEvent event,
    Emitter<AddStudentNoticeState> emit,
  ) {
    final updatedSelection = Set<String>.from(state.selectedStudentIds);
    if (updatedSelection.contains(event.studentId)) {
      updatedSelection.remove(event.studentId);
    } else {
      updatedSelection.add(event.studentId);
    }
    emit(state.copyWith(selectedStudentIds: updatedSelection));
  }

  void _onToggleSelectAll(
    ToggleSelectAllEvent event,
    Emitter<AddStudentNoticeState> emit,
  ) {
    final filteredIds = state.filteredStudents.map((e) => e.id).toSet();
    final currentSelection = Set<String>.from(state.selectedStudentIds);

    // Check if all filtered are currently selected
    final bool areAllFilteredSelected =
        filteredIds.isNotEmpty &&
        filteredIds.every((id) => currentSelection.contains(id));

    if (areAllFilteredSelected) {
      // Deselect all filtered
      currentSelection.removeAll(filteredIds);
    } else {
      // Select all filtered
      currentSelection.addAll(filteredIds);
    }
    emit(state.copyWith(selectedStudentIds: currentSelection));
  }

  Future<void> _onSubmitNotice(
    SubmitNoticeEvent event,
    Emitter<AddStudentNoticeState> emit,
  ) async {
    if (state.selectedClass == null ||
        state.section == null ||
        state.title.isEmpty ||
        state.content.isEmpty) {
      emit(
        state.copyWith(
          error: 'Please fill all required fields',
          submitSuccess: false,
        ),
      );
      // Clear error so it doesn't persist
      emit(state.copyWith(error: null));
      return;
    }

    emit(state.copyWith(isSubmitting: true, error: null));
    try {
      final success = await _repository.submitNotice(
        classId: state.selectedClass!,
        sectionId: state.section!,
        date: state.date,
        title: state.title,
        content: state.content,
        studentIds: state.selectedStudentIds.toList(),
        imagePath: state.imagePath,
        docPath: state.documentPath,
      );
      emit(state.copyWith(isSubmitting: false, submitSuccess: success));
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, error: e.toString()));
    }
  }
}
