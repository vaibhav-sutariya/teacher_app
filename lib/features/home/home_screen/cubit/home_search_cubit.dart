import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/menu_data.dart';
import 'home_search_state.dart';

class HomeSearchCubit extends Cubit<HomeSearchState> {
  HomeSearchCubit()
    : super(const HomeSearchState(filteredSections: QuickMenuData.sections));

  Timer? _debounceTimer;
  static const _debounceDuration = Duration(milliseconds: 200);

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }

  void search(String query) {
    // Cancel previous timer if exists
    _debounceTimer?.cancel();

    // Debounce the search to avoid excessive rebuilds
    _debounceTimer = Timer(_debounceDuration, () {
      _performSearch(query);
    });
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      emit(
        state.copyWith(
          filteredSections: QuickMenuData.sections,
          isSearching: false,
        ),
      );
      return;
    }

    final lowerQuery = query.toLowerCase();
    final List<MenuSectionData> filtered = [];

    for (final section in QuickMenuData.sections) {
      final matchingItems = section.items.where((item) {
        return item.label.toLowerCase().contains(lowerQuery);
      }).toList();

      if (matchingItems.isNotEmpty) {
        // Only create new object if there are matching items
        filtered.add(
          MenuSectionData(
            title: section.title,
            sectionColor: section.sectionColor,
            items: matchingItems,
          ),
        );
      }
    }

    emit(state.copyWith(filteredSections: filtered, isSearching: true));
  }

  /// Immediate search without debouncing (useful for programmatic searches)
  void searchImmediate(String query) {
    _debounceTimer?.cancel();
    _performSearch(query);
  }
}
