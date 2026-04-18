import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/birthday_member_model.dart';

part 'birthday_event.dart';
part 'birthday_state.dart';

class BirthdayBloc extends Bloc<BirthdayEvent, BirthdayState> {
  BirthdayBloc() : super(BirthdayState.initial()) {
    on<LoadMonthBirthdays>(_onLoadBirthdays);
    on<SelectBirthdayDate>(_onSelectDate);
    on<ChangeBirthdayMonth>(_onChangeMonth);
  }

  void _onLoadBirthdays(
    LoadMonthBirthdays event,
    Emitter<BirthdayState> emit,
  ) async {
    emit(state.copyWith(status: BirthdayStatus.loading));
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      final mockBirthdays = [
        // March Student Birthdays
        BirthdayMemberModel(
          name: 'Arjun Sharma',
          subTitle: 'Class 10-A',
          dob: DateTime(2010, 3, 2),
          type: BirthdayType.student,
        ),
        BirthdayMemberModel(
          name: 'Priya Patel',
          subTitle: 'Class 8-B',
          dob: DateTime(2012, 3, 10),
          type: BirthdayType.student,
        ),
        BirthdayMemberModel(
          name: 'Rohan Gupta',
          subTitle: 'Class 9-C',
          dob: DateTime(2011, 3, 18),
          type: BirthdayType.student,
        ),
        BirthdayMemberModel(
          name: 'Sanya Malhotra',
          subTitle: 'Class 10-A',
          dob: DateTime(2010, 3, 25),
          type: BirthdayType.student,
        ),
        BirthdayMemberModel(
          name: 'Ishan Verma',
          subTitle: 'Class 7-A',
          dob: DateTime(2013, 3, 25),
          type: BirthdayType.student,
        ),

        // March Teacher Birthdays
        BirthdayMemberModel(
          name: 'Dr. Sameer Khan',
          subTitle: 'Mathematics Dept.',
          dob: DateTime(1985, 3, 10),
          type: BirthdayType.teacher,
        ),
        BirthdayMemberModel(
          name: 'Mrs. Anjali Desai',
          subTitle: 'English Dept.',
          dob: DateTime(1990, 3, 27),
          type: BirthdayType.teacher,
        ),
        BirthdayMemberModel(
          name: 'Mr. Rajesh Kumar',
          subTitle: 'Science Dept.',
          dob: DateTime(1982, 3, 25),
          type: BirthdayType.teacher,
        ),
      ];

      emit(
        state.copyWith(
          status: BirthdayStatus.loaded,
          birthdays: mockBirthdays,
          focusedMonth: event.month,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: BirthdayStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onSelectDate(SelectBirthdayDate event, Emitter<BirthdayState> emit) {
    emit(state.copyWith(selectedDate: event.date));
  }

  void _onChangeMonth(ChangeBirthdayMonth event, Emitter<BirthdayState> emit) {
    add(LoadMonthBirthdays(event.month));
  }
}
