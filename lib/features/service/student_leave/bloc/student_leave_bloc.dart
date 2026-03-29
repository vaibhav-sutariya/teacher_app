import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/student_leave_model.dart';

// Events
abstract class StudentLeaveEvent extends Equatable {
  const StudentLeaveEvent();
  @override
  List<Object?> get props => [];
}

class LoadStudentLeaves extends StudentLeaveEvent {}

class ChangeStudentLeaveTab extends StudentLeaveEvent {
  final int index;
  const ChangeStudentLeaveTab(this.index);
  @override
  List<Object?> get props => [index];
}

// States
abstract class StudentLeaveState extends Equatable {
  const StudentLeaveState();
  @override
  List<Object?> get props => [];
}

class StudentLeaveInitial extends StudentLeaveState {}

class StudentLeaveLoading extends StudentLeaveState {}

class StudentLeaveLoaded extends StudentLeaveState {
  final int selectedTabIndex;
  final List<StudentLeaveModel> pendingList;
  final List<StudentLeaveModel> approvedList;
  final List<StudentLeaveModel> rejectedList;

  const StudentLeaveLoaded({
    required this.selectedTabIndex,
    required this.pendingList,
    required this.approvedList,
    required this.rejectedList,
  });

  StudentLeaveLoaded copyWith({
    int? selectedTabIndex,
    List<StudentLeaveModel>? pendingList,
    List<StudentLeaveModel>? approvedList,
    List<StudentLeaveModel>? rejectedList,
  }) {
    return StudentLeaveLoaded(
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      pendingList: pendingList ?? this.pendingList,
      approvedList: approvedList ?? this.approvedList,
      rejectedList: rejectedList ?? this.rejectedList,
    );
  }

  @override
  List<Object?> get props => [
        selectedTabIndex,
        pendingList,
        approvedList,
        rejectedList,
      ];
}

class StudentLeaveError extends StudentLeaveState {
  final String message;
  const StudentLeaveError(this.message);
  @override
  List<Object?> get props => [message];
}

// Bloc
class StudentLeaveBloc extends Bloc<StudentLeaveEvent, StudentLeaveState> {
  StudentLeaveBloc() : super(StudentLeaveInitial()) {
    on<LoadStudentLeaves>(_onLoadStudentLeaves);
    on<ChangeStudentLeaveTab>(_onChangeStudentLeaveTab);
  }

  Future<void> _onLoadStudentLeaves(
    LoadStudentLeaves event,
    Emitter<StudentLeaveState> emit,
  ) async {
    emit(StudentLeaveLoading());
    try {
      // Simulate network request
      await Future.delayed(const Duration(milliseconds: 600));
      final allLeaves = StudentLeaveModel.getMockData();
      
      final pending = allLeaves
          .where((l) => l.status == StudentLeaveStatus.pending)
          .toList();
      final approved = allLeaves
          .where((l) => l.status == StudentLeaveStatus.approved)
          .toList();
      final rejected = allLeaves
          .where((l) => l.status == StudentLeaveStatus.rejected)
          .toList();

      emit(StudentLeaveLoaded(
        selectedTabIndex: 0,
        pendingList: pending,
        approvedList: approved,
        rejectedList: rejected,
      ));
    } catch (e) {
      emit(StudentLeaveError(e.toString()));
    }
  }

  void _onChangeStudentLeaveTab(
    ChangeStudentLeaveTab event,
    Emitter<StudentLeaveState> emit,
  ) {
    if (state is StudentLeaveLoaded) {
      emit((state as StudentLeaveLoaded).copyWith(selectedTabIndex: event.index));
    }
  }
}
