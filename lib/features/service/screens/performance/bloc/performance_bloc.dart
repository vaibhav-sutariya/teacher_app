import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/features/school/models/history_model.dart';
import 'package:teachers_app/features/school/models/staff_model.dart';

// Events
abstract class PerformanceEvent extends Equatable {
  const PerformanceEvent();
  @override
  List<Object?> get props => [];
}

class LoadPerformanceHistory extends PerformanceEvent {}

class ChangePerformanceMonth extends PerformanceEvent {
  final DateTime month;
  const ChangePerformanceMonth(this.month);
  @override
  List<Object?> get props => [month];
}

// Status
enum PerformanceStatus { initial, loading, loaded, error }

// State
class PerformanceState extends Equatable {
  final PerformanceStatus status;
  final List<StaffAttendanceHistoryLog> logs;
  final DateTime selectedMonth;
  final String? errorMessage;
  final StaffMember teacher;

  const PerformanceState({
    required this.status,
    required this.logs,
    required this.selectedMonth,
    required this.teacher,
    this.errorMessage,
  });

  factory PerformanceState.initial() {
    return PerformanceState(
      status: PerformanceStatus.initial,
      logs: const [],
      selectedMonth: DateTime.now(),
      teacher: const StaffMember(
        id: 'teacher_1',
        name: 'VAIBHAV SUTARIYA',
        designation: 'Teacher',
        profileImage: null,
      ),
    );
  }

  PerformanceState copyWith({
    PerformanceStatus? status,
    List<StaffAttendanceHistoryLog>? logs,
    DateTime? selectedMonth,
    String? errorMessage,
  }) {
    return PerformanceState(
      status: status ?? this.status,
      logs: logs ?? this.logs,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      teacher: teacher,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  // Summary Getters
  int get totalPresent =>
      logs.where((l) => l.status == StaffHistoryStatus.present).length;
  int get totalAbsent =>
      logs.where((l) => l.status == StaffHistoryStatus.absent).length;
  int get totalLeave =>
      logs.where((l) => l.status == StaffHistoryStatus.leave).length;
  int get totalHoliday =>
      logs.where((l) => l.status == StaffHistoryStatus.holiday).length;
  int get totalWeekOff =>
      logs.where((l) => l.status == StaffHistoryStatus.weekOff).length;

  @override
  List<Object?> get props => [
    status,
    logs,
    selectedMonth,
    teacher,
    errorMessage,
  ];
}

// Bloc
class PerformanceBloc extends Bloc<PerformanceEvent, PerformanceState> {
  PerformanceBloc() : super(PerformanceState.initial()) {
    on<LoadPerformanceHistory>(_onLoadPerformanceHistory);
    on<ChangePerformanceMonth>(_onChangePerformanceMonth);
  }

  Future<void> _onLoadPerformanceHistory(
    LoadPerformanceHistory event,
    Emitter<PerformanceState> emit,
  ) async {
    emit(state.copyWith(status: PerformanceStatus.loading));
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final logs = StaffAttendanceHistoryLog.getMockLogs(state.selectedMonth);
      emit(state.copyWith(status: PerformanceStatus.loaded, logs: logs));
    } catch (e) {
      emit(
        state.copyWith(
          status: PerformanceStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onChangePerformanceMonth(
    ChangePerformanceMonth event,
    Emitter<PerformanceState> emit,
  ) {
    emit(state.copyWith(selectedMonth: event.month));
    add(LoadPerformanceHistory());
  }
}
