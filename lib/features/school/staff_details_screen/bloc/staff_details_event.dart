part of 'staff_details_bloc.dart';

abstract class StaffDetailsEvent extends Equatable {
  const StaffDetailsEvent();

  @override
  List<Object?> get props => [];
}

class LoadStaffList extends StaffDetailsEvent {}

class SearchStaff extends StaffDetailsEvent {
  final String query;
  const SearchStaff(this.query);

  @override
  List<Object?> get props => [query];
}
