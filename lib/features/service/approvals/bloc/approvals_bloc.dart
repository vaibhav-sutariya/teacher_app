import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/approval_models.dart';

// Events
abstract class ApprovalsEvent extends Equatable {
  const ApprovalsEvent();
  @override
  List<Object?> get props => [];
}

class LoadApprovals extends ApprovalsEvent {}

class ChangeTab extends ApprovalsEvent {
  final int index;
  const ChangeTab(this.index);
  @override
  List<Object?> get props => [index];
}

// State
abstract class ApprovalsState extends Equatable {
  const ApprovalsState();
  @override
  List<Object?> get props => [];
}

class ApprovalsInitial extends ApprovalsState {}

class ApprovalsLoading extends ApprovalsState {}

class ApprovalsLoaded extends ApprovalsState {
  final List<ApprovalItem> peningApprovals;
  final List<ApprovalItem> approvedApprovals;
  final List<ApprovalItem> rejectedApprovals;
  final int selectedTabIndex;

  const ApprovalsLoaded({
    required this.peningApprovals,
    required this.approvedApprovals,
    required this.rejectedApprovals,
    this.selectedTabIndex = 0,
  });

  ApprovalsLoaded copyWith({
    List<ApprovalItem>? peningApprovals,
    List<ApprovalItem>? approvedApprovals,
    List<ApprovalItem>? rejectedApprovals,
    int? selectedTabIndex,
  }) {
    return ApprovalsLoaded(
      peningApprovals: peningApprovals ?? this.peningApprovals,
      approvedApprovals: approvedApprovals ?? this.approvedApprovals,
      rejectedApprovals: rejectedApprovals ?? this.rejectedApprovals,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
    );
  }

  @override
  List<Object?> get props => [
    peningApprovals,
    approvedApprovals,
    rejectedApprovals,
    selectedTabIndex,
  ];
}

class ApprovalsError extends ApprovalsState {
  final String message;
  const ApprovalsError(this.message);
  @override
  List<Object?> get props => [message];
}

// Bloc
class ApprovalsBloc extends Bloc<ApprovalsEvent, ApprovalsState> {
  ApprovalsBloc() : super(ApprovalsInitial()) {
    on<LoadApprovals>(_onLoadApprovals);
    on<ChangeTab>(_onChangeTab);
  }

  Future<void> _onLoadApprovals(
    LoadApprovals event,
    Emitter<ApprovalsState> emit,
  ) async {
    emit(ApprovalsLoading());
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      final mockData = ApprovalItem.getMockData();
      
      final pending = mockData.where((item) => item.status == ApprovalStatus.pending).toList();
      final approved = mockData.where((item) => item.status == ApprovalStatus.approved).toList();
      final rejected = mockData.where((item) => item.status == ApprovalStatus.rejected).toList();

      emit(ApprovalsLoaded(
        peningApprovals: pending,
        approvedApprovals: approved,
        rejectedApprovals: rejected,
      ));
    } catch (e) {
      emit(ApprovalsError(e.toString()));
    }
  }

  void _onChangeTab(
    ChangeTab event,
    Emitter<ApprovalsState> emit,
  ) {
    if (state is ApprovalsLoaded) {
      emit((state as ApprovalsLoaded).copyWith(selectedTabIndex: event.index));
    }
  }
}
