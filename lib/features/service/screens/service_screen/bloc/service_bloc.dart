import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../models/service_model.dart';

part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  ServiceBloc() : super(ServiceInitial()) {
    on<LoadServiceData>(_onLoadServiceData);
    on<SearchService>(_onSearchService);
  }

  void _onLoadServiceData(LoadServiceData event, Emitter<ServiceState> emit) {
    emit(ServiceLoading());
    try {
      final items = ServiceModel.getServiceItems();
      emit(ServiceLoaded(items: items, filteredItems: items));
    } catch (e) {
      emit(ServiceError(e.toString()));
    }
  }

  void _onSearchService(SearchService event, Emitter<ServiceState> emit) {
    if (state is ServiceLoaded) {
      final currentState = state as ServiceLoaded;
      final query = event.query.toLowerCase();
      
      final filtered = currentState.items.where((item) {
        return item.label.toLowerCase().contains(query);
      }).toList();
      
      emit(ServiceLoaded(
        items: currentState.items,
        filteredItems: filtered,
        searchQuery: event.query,
      ));
    }
  }
}
