part of 'service_bloc.dart';

abstract class ServiceState extends Equatable {
  const ServiceState();

  @override
  List<Object?> get props => [];
}

class ServiceInitial extends ServiceState {}

class ServiceLoading extends ServiceState {}

class ServiceLoaded extends ServiceState {
  final List<ServiceModel> items;
  final List<ServiceModel> filteredItems;
  final String searchQuery;

  const ServiceLoaded({
    required this.items,
    required this.filteredItems,
    this.searchQuery = '',
  });

  @override
  List<Object?> get props => [items, filteredItems, searchQuery];
}

class ServiceError extends ServiceState {
  final String message;
  const ServiceError(this.message);

  @override
  List<Object?> get props => [message];
}
