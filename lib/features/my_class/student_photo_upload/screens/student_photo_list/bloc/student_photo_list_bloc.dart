import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../models/student_list_model.dart';

part 'student_photo_list_event.dart';
part 'student_photo_list_state.dart';

class StudentPhotoListBloc
    extends Bloc<StudentPhotoListEvent, StudentPhotoListState> {
  StudentPhotoListBloc() : super(const StudentPhotoListState()) {
    on<LoadStudents>(_onLoadStudents);
    on<SearchStudents>(_onSearchStudents);
    on<UpdateStudentPhoto>(_onUpdateStudentPhoto);
  }

  void _onLoadStudents(
    LoadStudents event,
    Emitter<StudentPhotoListState> emit,
  ) async {
    emit(
      state.copyWith(
        status: StudentPhotoListStatus.loading,
        className: event.className,
      ),
    );
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      final mockStudents = [
        StudentListModel(
          id: '1',
          name: 'AYALDASANI NISHKA KAPIL',
          className: event.className,
          rollNo: '1',
          isUploaded: true,
          photoUrl: 'https://via.placeholder.com/150',
        ),
        StudentListModel(
          id: '2',
          name: 'DESAI SHELVI AJAY',
          className: event.className,
          rollNo: '2',
          isUploaded: true,
          photoUrl: 'https://via.placeholder.com/150',
        ),
        StudentListModel(
          id: '3',
          name: 'GOL YANA CHIRAGKUMAR',
          className: event.className,
          rollNo: '3',
          isUploaded: true,
          photoUrl: 'https://via.placeholder.com/150',
        ),
        StudentListModel(
          id: '4',
          name: 'GOSAI MISTY JATINGIRI',
          className: event.className,
          rollNo: '4',
          isUploaded: true,
          photoUrl: 'https://via.placeholder.com/150',
        ),
        StudentListModel(
          id: '5',
          name: 'JANGADE HAZEL KALPEN',
          className: event.className,
          rollNo: '5',
          isUploaded: true,
          photoUrl: 'https://via.placeholder.com/150',
        ),
        StudentListModel(
          id: '6',
          name: 'KRIPLANI KHANISHKA KUNAL',
          className: event.className,
          rollNo: '6',
          isUploaded: true,
          photoUrl: 'https://via.placeholder.com/150',
        ),
        StudentListModel(
          id: '7',
          name: 'LUNAGARIA MISHVA KISHAN',
          className: event.className,
          rollNo: '7',
          isUploaded: true,
          photoUrl: 'https://via.placeholder.com/150',
        ),
        StudentListModel(
          id: '8',
          name: 'MAHETA KAVYA ARJUN',
          className: event.className,
          rollNo: '8',
          isUploaded: false,
          photoUrl: 'https://via.placeholder.com/150',
        ),
      ];

      emit(
        state.copyWith(
          status: StudentPhotoListStatus.loaded,
          students: mockStudents,
          filteredStudents: mockStudents,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: StudentPhotoListStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onSearchStudents(
    SearchStudents event,
    Emitter<StudentPhotoListState> emit,
  ) {
    final query = event.query.toLowerCase();
    final filtered = state.students.where((s) {
      return s.name.toLowerCase().contains(query) || s.rollNo.contains(query);
    }).toList();

    emit(state.copyWith(searchQuery: event.query, filteredStudents: filtered));
  }

  void _onUpdateStudentPhoto(
    UpdateStudentPhoto event,
    Emitter<StudentPhotoListState> emit,
  ) {
    final updatedStudents = state.students.map((s) {
      if (s.id == event.studentId) {
        return StudentListModel(
          id: s.id,
          name: s.name,
          className: s.className,
          rollNo: s.rollNo,
          isUploaded: true,
          photoUrl: s.photoUrl,
        );
      }
      return s;
    }).toList();

    final filtered = updatedStudents.where((s) {
      final query = state.searchQuery?.toLowerCase() ?? '';
      return s.name.toLowerCase().contains(query) || s.rollNo.contains(query);
    }).toList();

    emit(state.copyWith(students: updatedStudents, filteredStudents: filtered));
  }
}
