import 'package:equatable/equatable.dart';
import '../models/gate_pass_model.dart';

enum GatePassPageStatus { initial, loading, loaded, error }

class GatePassState extends Equatable {
  final GatePassPageStatus status;
  final List<GatePassModel> allGatePasses;
  final List<GatePassModel> filteredGatePasses;
  final int selectedTabIndex;
  final String? errorMessage;

  const GatePassState({
    this.status = GatePassPageStatus.initial,
    this.allGatePasses = const [],
    this.filteredGatePasses = const [],
    this.selectedTabIndex = 0,
    this.errorMessage,
  });

  GatePassState copyWith({
    GatePassPageStatus? status,
    List<GatePassModel>? allGatePasses,
    List<GatePassModel>? filteredGatePasses,
    int? selectedTabIndex,
    String? errorMessage,
  }) {
    return GatePassState(
      status: status ?? this.status,
      allGatePasses: allGatePasses ?? this.allGatePasses,
      filteredGatePasses: filteredGatePasses ?? this.filteredGatePasses,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    allGatePasses,
    filteredGatePasses,
    selectedTabIndex,
    errorMessage,
  ];
}
