import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/punch_models.dart';

// Events
abstract class PunchTrackerEvent extends Equatable {
  const PunchTrackerEvent();
  @override
  List<Object?> get props => [];
}

class LoadPunchData extends PunchTrackerEvent {
  final DateTime month;
  const LoadPunchData(this.month);
  @override
  List<Object?> get props => [month];
}

class ChangePunchTab extends PunchTrackerEvent {
  final int index;
  const ChangePunchTab(this.index);
  @override
  List<Object?> get props => [index];
}

class ChangePunchMonth extends PunchTrackerEvent {
  final bool next;
  const ChangePunchMonth({required this.next});
  @override
  List<Object?> get props => [next];
}

// State
abstract class PunchTrackerState extends Equatable {
  const PunchTrackerState();
  @override
  List<Object?> get props => [];
}

class PunchTrackerInitial extends PunchTrackerState {}

class PunchTrackerLoading extends PunchTrackerState {}

class PunchTrackerLoaded extends PunchTrackerState {
  final List<PunchRecord> records;
  final int selectedTabIndex;
  final DateTime selectedMonth;

  const PunchTrackerLoaded({
    required this.records,
    required this.selectedTabIndex,
    required this.selectedMonth,
  });

  PunchTrackerLoaded copyWith({
    List<PunchRecord>? records,
    int? selectedTabIndex,
    DateTime? selectedMonth,
  }) {
    return PunchTrackerLoaded(
      records: records ?? this.records,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      selectedMonth: selectedMonth ?? this.selectedMonth,
    );
  }

  @override
  List<Object?> get props => [records, selectedTabIndex, selectedMonth];
}

class PunchTrackerError extends PunchTrackerState {
  final String message;
  const PunchTrackerError(this.message);
  @override
  List<Object?> get props => [message];
}

// Bloc
class PunchTrackerBloc extends Bloc<PunchTrackerEvent, PunchTrackerState> {
  PunchTrackerBloc() : super(PunchTrackerInitial()) {
    on<LoadPunchData>(_onLoadPunchData);
    on<ChangePunchTab>(_onChangePunchTab);
    on<ChangePunchMonth>(_onChangePunchMonth);
  }

  Future<void> _onLoadPunchData(
    LoadPunchData event,
    Emitter<PunchTrackerState> emit,
  ) async {
    emit(PunchTrackerLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final records = PunchRecord.getMockData(event.month);
      emit(PunchTrackerLoaded(
        records: records,
        selectedTabIndex: 0,
        selectedMonth: event.month,
      ));
    } catch (e) {
      emit(PunchTrackerError(e.toString()));
    }
  }

  void _onChangePunchTab(
    ChangePunchTab event,
    Emitter<PunchTrackerState> emit,
  ) {
    if (state is PunchTrackerLoaded) {
      emit((state as PunchTrackerLoaded).copyWith(selectedTabIndex: event.index));
    }
  }

  void _onChangePunchMonth(
    ChangePunchMonth event,
    Emitter<PunchTrackerState> emit,
  ) {
    if (state is PunchTrackerLoaded) {
      final currentState = state as PunchTrackerLoaded;
      final newMonth = DateTime(
        currentState.selectedMonth.year,
        currentState.selectedMonth.month + (event.next ? 1 : -1),
      );
      add(LoadPunchData(newMonth));
    }
  }
}
