import 'package:flutter_bloc/flutter_bloc.dart';
import 'classwork_subject_event.dart';
import 'classwork_subject_state.dart';

class ClassworkSubjectBloc
    extends Bloc<ClassworkSubjectEvent, ClassworkSubjectState> {
  final Map<String, List<String>> _mockSubjects = {
    'LITTLE CHAMPS': ['English', 'Math', 'Drawing'],
    'JR.KG': ['English', 'Hindi', 'Math', 'Rhymes'],
    'SR.KG': ['English', 'Hindi', 'Math', 'G.K.'],
    '1st': ['Mathematics', 'English', 'Science', 'Gujarati', 'Hindi'],
    '2nd': ['Mathematics', 'English', 'Science', 'Social Studies', 'Hindi'],
    'DEFAULT': ['English', 'Mathematics', 'Science', 'Social Studies'],
  };

  ClassworkSubjectBloc() : super(ClassworkSubjectInitial()) {
    on<LoadClassworkSubjectsEvent>(_onLoadSubjects);
  }

  Future<void> _onLoadSubjects(
    LoadClassworkSubjectsEvent event,
    Emitter<ClassworkSubjectState> emit,
  ) async {
    emit(ClassworkSubjectLoading());
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    final subjects =
        _mockSubjects[event.className] ?? _mockSubjects['DEFAULT']!;

    emit(ClassworkSubjectLoaded(subjects));
  }
}
