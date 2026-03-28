part of 'school_bloc.dart';

enum SchoolManagementStatus { initial, loading, loaded, error }

class SchoolState extends Equatable {
  final SchoolManagementStatus status;
  final List<SchoolModuleModel> modules;
  final String? errorMessage;
  final bool isRefreshing;

  const SchoolState({
    this.status = SchoolManagementStatus.loaded,
    this.modules = const [],
    this.errorMessage,
    this.isRefreshing = false,
  });

  SchoolState copyWith({
    SchoolManagementStatus? status,
    List<SchoolModuleModel>? modules,
    String? errorMessage,
    bool? isRefreshing,
  }) {
    return SchoolState(
      status: status ?? this.status,
      modules: modules ?? this.modules,
      errorMessage: errorMessage ?? this.errorMessage,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  @override
  List<Object?> get props => [status, modules, errorMessage, isRefreshing];
}
