part of 'service_bloc.dart';

abstract class ServiceEvent extends Equatable {
  const ServiceEvent();

  @override
  List<Object> get props => [];
}

class LoadServiceData extends ServiceEvent {}

class SearchService extends ServiceEvent {
  final String query;
  const SearchService(this.query);

  @override
  List<Object> get props => [query];
}
