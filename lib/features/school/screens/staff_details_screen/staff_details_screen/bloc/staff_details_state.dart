part of 'staff_details_bloc.dart';

enum StaffDetailsStatus { initial, loading, loaded, error }

class StaffDetailsState extends Equatable {
  final StaffDetailsStatus status;
  final List<StaffMember> originalList;
  final List<StaffMember> filteredList;
  final String? errorMessage;

  const StaffDetailsState({
    required this.status,
    this.originalList = const [],
    this.filteredList = const [],
    this.errorMessage,
  });

  StaffDetailsState copyWith({
    StaffDetailsStatus? status,
    List<StaffMember>? originalList,
    List<StaffMember>? filteredList,
    String? errorMessage,
  }) {
    return StaffDetailsState(
      status: status ?? this.status,
      originalList: originalList ?? this.originalList,
      filteredList: filteredList ?? this.filteredList,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, originalList, filteredList, errorMessage];
}
