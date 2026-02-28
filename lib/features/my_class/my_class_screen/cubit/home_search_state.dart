import 'package:equatable/equatable.dart';

import '../data/menu_data.dart';

class HomeSearchState extends Equatable {
  final List<MenuSectionData> filteredSections;
  final bool isSearching;

  const HomeSearchState({
    this.filteredSections = const [],
    this.isSearching = false,
  });

  HomeSearchState copyWith({
    List<MenuSectionData>? filteredSections,
    bool? isSearching,
  }) {
    return HomeSearchState(
      filteredSections: filteredSections ?? this.filteredSections,
      isSearching: isSearching ?? this.isSearching,
    );
  }

  @override
  List<Object> get props => [filteredSections, isSearching];
}
