part of 'service_bloc.dart';

abstract class ServiceState extends Equatable {
  const ServiceState();

  @override
  List<Object?> get props => [];
}

class NoticeInitial extends ServiceState {}

class ServiceLoadedState extends ServiceState {
  final List<ServiceModel> noticeList;
  final DateTime selectedMonth;
  final bool isLoading;

  const ServiceLoadedState({
    required this.noticeList,
    required this.selectedMonth,
    this.isLoading = false,
  });

  ServiceLoadedState copyWith({
    List<ServiceModel>? noticeList,
    DateTime? selectedMonth,
    bool? isLoading,
  }) {
    return ServiceLoadedState(
      noticeList: noticeList ?? this.noticeList,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [noticeList, selectedMonth, isLoading];
}

class ServiceError extends ServiceState {
  final String message;

  const ServiceError(this.message);

  @override
  List<Object?> get props => [message];
}
