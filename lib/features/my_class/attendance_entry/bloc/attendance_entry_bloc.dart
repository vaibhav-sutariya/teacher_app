import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/student_attendance_model.dart';
import 'attendance_entry_event_state.dart';

class AttendanceEntryBloc
    extends Bloc<AttendanceEntryEvent, AttendanceEntryState> {
  AttendanceEntryBloc() : super(AttendanceEntryState.initial()) {
    on<LoadAttendanceEntry>(_onLoadAttendance);
    on<ToggleSendSms>(_onToggleSms);
    on<MarkStudentStatus>(_onMarkStatus);
    on<ChangeSpecialStatus>(_onChangeSpecialStatus);
  }

  void _onLoadAttendance(
    LoadAttendanceEntry event,
    Emitter<AttendanceEntryState> emit,
  ) {
    emit(
      state.copyWith(
        isLoading: true,
        className: event.className,
        date: event.date,
      ),
    );

    // Simulate API fetch with mock data based on the screenshot requirement
    final mockStudents = [
      const StudentAttendanceModel(
        studentId: '1',
        name: 'Aarav Sharma',
        rollNoString: 'Roll No: 202401',
        rollNumber: 1,
        imageUrl: 'https://i.pravatar.cc/150?u=aarav',
        status: AttendanceStatusEnum.present,
      ),
      const StudentAttendanceModel(
        studentId: '2',
        name: 'Ananya Iyer',
        rollNoString: 'Roll No: 202402',
        rollNumber: 2,
        imageUrl: 'https://i.pravatar.cc/150?u=ananya',
        status: AttendanceStatusEnum.absent,
      ),
      const StudentAttendanceModel(
        studentId: '3',
        name: 'Vivaan Gupta',
        rollNoString: 'Roll No: 202403',
        rollNumber: 3,
        imageUrl: 'https://i.pravatar.cc/150?u=vivaan',
        status: AttendanceStatusEnum.present,
      ),
      const StudentAttendanceModel(
        studentId: '4',
        name: 'Kiara Mehta',
        rollNoString: 'Roll No: 202404',
        rollNumber: 4,
        imageUrl: 'https://i.pravatar.cc/150?u=kiara',
        status: AttendanceStatusEnum.present,
      ),
      const StudentAttendanceModel(
        studentId: '5',
        name: 'Kabir Singh',
        rollNoString: 'Roll No: 202405',
        rollNumber: 5,
        imageUrl: 'https://i.pravatar.cc/150?u=kabir',
        status: AttendanceStatusEnum.notMarked,
      ),
    ];

    emit(state.copyWith(isLoading: false, students: mockStudents));
  }

  void _onToggleSms(ToggleSendSms event, Emitter<AttendanceEntryState> emit) {
    emit(state.copyWith(sendSms: event.value));
  }

  void _onMarkStatus(
    MarkStudentStatus event,
    Emitter<AttendanceEntryState> emit,
  ) {
    final newStudents = state.students.map((student) {
      if (student.studentId == event.studentId) {
        return student.copyWith(status: event.status);
      }
      return student;
    }).toList();
    emit(state.copyWith(students: newStudents));
  }

  void _onChangeSpecialStatus(
    ChangeSpecialStatus event,
    Emitter<AttendanceEntryState> emit,
  ) {
    final newStudents = state.students.map((student) {
      if (student.studentId == event.studentId) {
        return student.copyWith(specialStatus: event.specialStatus);
      }
      return student;
    }).toList();
    emit(state.copyWith(students: newStudents));
  }
}
