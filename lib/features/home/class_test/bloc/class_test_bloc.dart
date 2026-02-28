import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/class_test_model.dart';

part 'class_test_event.dart';
part 'class_test_state.dart';

class ClassTestBloc extends Bloc<ClassTestEvent, ClassTestState> {
  ClassTestBloc() : super(ClassTestInitial()) {
    on<ClassTestLoaded>(_onClassTestLoaded);
  }

  Future<void> _onClassTestLoaded(
    ClassTestLoaded event,
    Emitter<ClassTestState> emit,
  ) async {
    emit(ClassTestLoading());

    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Load mock data
      final classTestList = ClassTestModel.getMockData();

      emit(ClassTestLoadedState(classTestList));
    } catch (e) {
      emit(ClassTestError('Failed to load class tests: ${e.toString()}'));
    }
  }
}
