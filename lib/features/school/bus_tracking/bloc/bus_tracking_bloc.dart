import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/bus_model.dart';

part 'bus_tracking_event.dart';
part 'bus_tracking_state.dart';

class BusTrackingBloc extends Bloc<BusTrackingEvent, BusTrackingState> {
  BusTrackingBloc() : super(BusTrackingInitial()) {
    on<LoadBuses>(_onLoadBuses);
    on<RefreshBuses>(_onRefreshBuses);
  }

  Future<void> _onLoadBuses(LoadBuses event, Emitter<BusTrackingState> emit) async {
    emit(BusTrackingLoading());
    try {
      // Mock data for initial load
      await Future.delayed(const Duration(milliseconds: 800));
      final buses = _generateMockBuses();
      emit(BusTrackingLoaded(buses: buses));
    } catch (e) {
      emit(BusTrackingError(message: e.toString()));
    }
  }

  Future<void> _onRefreshBuses(RefreshBuses event, Emitter<BusTrackingState> emit) async {
    // We don't necessarily emit Loading if it's already Loaded to avoid flicker
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final buses = _generateMockBuses();
      emit(BusTrackingLoaded(buses: buses));
    } catch (e) {
      // Don't change state on refresh error if we already have data, otherwise emit error
      if (state is! BusTrackingLoaded) {
        emit(BusTrackingError(message: e.toString()));
      }
    }
  }

  List<BusModel> _generateMockBuses() {
    return [
      BusModel(
        id: '1',
        busNumber: 'MH 12 AB 1234',
        routeName: 'Route A - City Center',
        status: BusStatus.running,
        driverName: 'Mr. Ramesh Singh',
        driverPhone: '9876543210',
        speed: '35 km/h',
        lastLocation: 'Near Victory Garden, Sector 15',
        lastUpdated: DateTime.now(),
      ),
      BusModel(
        id: '2',
        busNumber: 'MH 12 XY 5678',
        routeName: 'Route B - West Colony',
        status: BusStatus.stopped,
        driverName: 'Mr. Suresh Patil',
        driverPhone: '9123456789',
        speed: '0 km/h',
        lastLocation: 'In Front of Blue Mall, Main Road',
        lastUpdated: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      BusModel(
        id: '3',
        busNumber: 'MH 12 CD 9012',
        routeName: 'Route C - East Extension',
        status: BusStatus.running,
        driverName: 'Mr. Vijay Kumar',
        driverPhone: '9988776655',
        speed: '42 km/h',
        lastLocation: 'Crossing Square, Building No. 4',
        lastUpdated: DateTime.now(),
      ),
      BusModel(
        id: '4',
        busNumber: 'MH 12 EF 3456',
        routeName: 'Route D - North Campus',
        status: BusStatus.delayed,
        driverName: 'Mr. Anil Deshkar',
        driverPhone: '8877665544',
        speed: '12 km/h',
        lastLocation: 'Underpass Bridge, Junction 2',
        lastUpdated: DateTime.now().subtract(const Duration(minutes: 10)),
      ),
    ];
  }
}
