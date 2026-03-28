import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/student_model.dart';
import '../repositories/student_info_repository.dart';

// --- EVENTS ---

abstract class StudentListEvent extends Equatable {
  const StudentListEvent();
  @override
  List<Object?> get props => [];
}

class LoadStudentsEvent extends StudentListEvent {
  final String classId;
  const LoadStudentsEvent(this.classId);
  @override
  List<Object?> get props => [classId];
}

class FilterStudentsEvent extends StudentListEvent {
  final String query;
  const FilterStudentsEvent(this.query);
  @override
  List<Object?> get props => [query];
}

// --- STATE ---

class StudentListState extends Equatable {
  final List<StudentModel> allStudents;
  final List<StudentModel> filteredStudents;
  final bool isLoading;
  final String searchQuery;
  final String? error;

  const StudentListState({
    this.allStudents = const [],
    this.filteredStudents = const [],
    this.isLoading = false,
    this.searchQuery = '',
    this.error,
  });

  factory StudentListState.initial() => const StudentListState();

  StudentListState copyWith({
    List<StudentModel>? allStudents,
    List<StudentModel>? filteredStudents,
    bool? isLoading,
    String? searchQuery,
    String? error,
  }) {
    return StudentListState(
      allStudents: allStudents ?? this.allStudents,
      filteredStudents: filteredStudents ?? this.filteredStudents,
      isLoading: isLoading ?? this.isLoading,
      searchQuery: searchQuery ?? this.searchQuery,
      error: error,
    );
  }

  @override
  List<Object?> get props => [allStudents, filteredStudents, isLoading, searchQuery, error];
}

// --- BLOC ---

class StudentListBloc extends Bloc<StudentListEvent, StudentListState> {
  final StudentInfoRepository repository;

  StudentListBloc({required this.repository}) : super(StudentListState.initial()) {
    on<LoadStudentsEvent>(_onLoadStudents);
    on<FilterStudentsEvent>(_onFilterStudents);
  }

  Future<void> _onLoadStudents(
    LoadStudentsEvent event,
    Emitter<StudentListState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await repository.getStudentsByClass(event.classId);
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure.message)),
      (students) => emit(state.copyWith(
        isLoading: false,
        allStudents: students,
        filteredStudents: students,
      )),
    );
  }

  void _onFilterStudents(
    FilterStudentsEvent event,
    Emitter<StudentListState> emit,
  ) {
    if (event.query.isEmpty) {
      emit(state.copyWith(filteredStudents: state.allStudents, searchQuery: ''));
    } else {
      final filtered = state.allStudents
          .where((s) => s.name.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(state.copyWith(filteredStudents: filtered, searchQuery: event.query));
    }
  }
}
