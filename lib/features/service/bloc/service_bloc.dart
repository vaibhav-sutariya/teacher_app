import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/service_model.dart';

part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final List<ServiceModel> _allServiceItems = ServiceModel.getServiceItems();

  ServiceBloc()
    : super(
        ServiceLoaded(
          items: ServiceModel.getServiceItems(),
          filteredItems: ServiceModel.getServiceItems(),
        ),
      ) {
    on<LoadServiceData>(_onLoadServiceData);
    on<RefreshServiceItems>(_onRefreshServiceItems);
    on<SearchServiceItems>(_onSearchServiceItems);
  }

  Future<void> _onLoadServiceData(
    LoadServiceData event,
    Emitter<ServiceState> emit,
  ) async {
    emit(
      ServiceLoaded(
        items: _allServiceItems,
        filteredItems: _allServiceItems,
      ),
    );
  }

  void _onSearchServiceItems(
    SearchServiceItems event,
    Emitter<ServiceState> emit,
  ) {
    if (state is ServiceLoaded) {
      final currentState = state as ServiceLoaded;
      final query = event.query.toLowerCase();

      if (query.isEmpty) {
        emit(
          currentState.copyWith(
            searchTerm: '',
            filteredItems: _allServiceItems,
          ),
        );
      } else {
        final filtered =
            _allServiceItems.where((item) {
              return item.label.toLowerCase().contains(query);
            }).toList();

        emit(
          currentState.copyWith(searchTerm: query, filteredItems: filtered),
        );
      }
    }
  }

  Future<void> _onRefreshServiceItems(
    RefreshServiceItems event,
    Emitter<ServiceState> emit,
  ) async {
    try {
      emit(
        ServiceLoaded(
          items: _allServiceItems,
          filteredItems: _allServiceItems,
        ),
      );
    } catch (e) {
      emit(ServiceError(message: e.toString()));
    }
  }
}
