part of 'service_bloc.dart';

abstract class ServiceEvent extends Equatable {
  const ServiceEvent();

  @override
  List<Object?> get props => [];
}

class LoadServiceData extends ServiceEvent {}

class RefreshServiceItems extends ServiceEvent {}

class SearchServiceItems extends ServiceEvent {
  final String query;
  const SearchServiceItems({required this.query});

  @override
  List<Object?> get props => [query];
}
