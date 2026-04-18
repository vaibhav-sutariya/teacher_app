import 'package:flutter_bloc/flutter_bloc.dart';
import 'subject_wise_homework_subject_event.dart';
import 'subject_wise_homework_subject_state.dart';

class SubjectWiseHomeworkSubjectBloc
    extends
        Bloc<SubjectWiseHomeworkSubjectEvent, SubjectWiseHomeworkSubjectState> {
  SubjectWiseHomeworkSubjectBloc()
    : super(SubjectWiseHomeworkSubjectInitial()) {
    on<LoadSubjectsEvent>(_onLoadSubjects);
  }

  Future<void> _onLoadSubjects(
    LoadSubjectsEvent event,
    Emitter<SubjectWiseHomeworkSubjectState> emit,
  ) async {
    emit(SubjectWiseHomeworkSubjectLoading());
    try {
      // Mocking subject fetch
      await Future.delayed(const Duration(milliseconds: 500));
      final mockSubjects = [
        'ENGLISH',
        'MATHEMATICS',
        'GENERAL KNOWLEDGE',
        'ART AND CRAFT',
        'ACTIVITY',
        'ENGLISH (WRITTEN AND ORAL)',
        'MATHS (WRITTEN AND ORAL)',
        'GENERAL KNOWLEDGE (WRITTEN AND',
        'DRAWING - COLOURING',
        'RHYMES - STORIES',
      ];
      emit(SubjectWiseHomeworkSubjectLoaded(mockSubjects));
    } catch (e) {
      emit(SubjectWiseHomeworkSubjectError(e.toString()));
    }
  }
}
