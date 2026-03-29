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
  final String searchTerm;

  const ServiceLoaded({
    required this.items,
    this.filteredItems = const [],
    this.searchTerm = '',
  });

  ServiceLoaded copyWith({
    List<ServiceModel>? items,
    List<ServiceModel>? filteredItems,
    String? searchTerm,
  }) {
    return ServiceLoaded(
      items: items ?? this.items,
      filteredItems: filteredItems ?? this.filteredItems,
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }

  @override
  List<Object?> get props => [items, filteredItems, searchTerm];
}

class ServiceError extends ServiceState {
  final String message;
  const ServiceError({required this.message});

  @override
  List<Object?> get props => [message];
}
