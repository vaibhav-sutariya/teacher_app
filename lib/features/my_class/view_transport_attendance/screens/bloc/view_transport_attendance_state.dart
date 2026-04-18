import 'package:equatable/equatable.dart';
import '../../models/transport_route_model.dart';

class ViewTransportAttendanceState extends Equatable {
  final DateTime selectedDate;
  final int selectedTabIndex;
  final List<TransportRouteModel> pendingRoutes;
  final List<TransportRouteModel> markedRoutes;
  final bool isLoading;
  final String? errorMessage;

  const ViewTransportAttendanceState({
    required this.selectedDate,
    this.selectedTabIndex = 0,
    this.pendingRoutes = const [],
    this.markedRoutes = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  factory ViewTransportAttendanceState.initial() {
    return ViewTransportAttendanceState(
      selectedDate: DateTime.now(),
      isLoading: true, // initial load
    );
  }

  ViewTransportAttendanceState copyWith({
    DateTime? selectedDate,
    int? selectedTabIndex,
    List<TransportRouteModel>? pendingRoutes,
    List<TransportRouteModel>? markedRoutes,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ViewTransportAttendanceState(
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      pendingRoutes: pendingRoutes ?? this.pendingRoutes,
      markedRoutes: markedRoutes ?? this.markedRoutes,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  ViewTransportAttendanceState clearError() {
    return ViewTransportAttendanceState(
      selectedDate: selectedDate,
      selectedTabIndex: selectedTabIndex,
      pendingRoutes: pendingRoutes,
      markedRoutes: markedRoutes,
      isLoading: isLoading,
      errorMessage: null,
    );
  }

  @override
  List<Object?> get props => [
    selectedDate,
    selectedTabIndex,
    pendingRoutes,
    markedRoutes,
    isLoading,
    errorMessage,
  ];
}
