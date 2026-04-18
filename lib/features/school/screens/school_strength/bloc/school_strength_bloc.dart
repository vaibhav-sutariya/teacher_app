import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../models/school_strength_model.dart';

part 'school_strength_event.dart';
part 'school_strength_state.dart';

class SchoolStrengthBloc
    extends Bloc<SchoolStrengthEvent, SchoolStrengthState> {
  SchoolStrengthBloc() : super(SchoolStrengthInitial()) {
    on<LoadSchoolStrength>(_onLoadStrength);
  }

  Future<void> _onLoadStrength(
    LoadSchoolStrength event,
    Emitter<SchoolStrengthState> emit,
  ) async {
    emit(SchoolStrengthLoading());
    try {
      // Mock data based on the provided image
      await Future.delayed(const Duration(milliseconds: 600));
      const strength = SchoolStrengthModel(
        totalStudents: 2448,
        girlsCount: 1161,
        boysCount: 1266,
        activeCount: 2427,
        promotedCount: 1914,
        newCount: 534,
        rteCount: 137,
        leftCount: 3,
        cancelCount: 18,
      );
      emit(SchoolStrengthLoaded(strength: strength));
    } catch (e) {
      emit(SchoolStrengthError(message: e.toString()));
    }
  }
}
