import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../cubit/home_search_cubit.dart';
import '../cubit/home_search_state.dart';
import '../data/menu_data.dart';
import 'menu_section_card.dart';

/// Custom scroll physics for WhatsApp-like smooth scrolling
/// Optimized for production performance
class SmoothScrollPhysics extends ClampingScrollPhysics {
  const SmoothScrollPhysics({super.parent});

  @override
  SmoothScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return SmoothScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double get minFlingVelocity => 50.0; // Lower threshold for smoother fling

  @override
  double get maxFlingVelocity => 8000.0; // Higher max velocity

  @override
  SpringDescription get spring => const SpringDescription(
        mass: 0.5, // Lower mass = faster response
        stiffness: 100.0, // Lower stiffness = smoother deceleration
        damping: 0.8, // Higher damping = less bounce
      );
}

/// Production-ready optimized list overlay with minimal rebuilds
class QuickMenuOverlay extends StatelessWidget {
  const QuickMenuOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeSearchCubit, HomeSearchState, List<MenuSectionData>>(
      selector: (state) => state.filteredSections,
      builder: (context, sections) {
        return BlocSelector<HomeSearchCubit, HomeSearchState, bool>(
          selector: (state) => state.isSearching,
          builder: (context, isSearching) {
            // Early return for empty state - prevents unnecessary ListView creation
            if (isSearching && sections.isEmpty) {
              return const _EmptyStateWidget();
            }

            return _OptimizedMenuList(
              sections: sections,
              key: ValueKey('menu_list_${sections.length}'),
            );
          },
        );
      },
    );
  }
}

/// Empty state widget - const for better performance
class _EmptyStateWidget extends StatelessWidget {
  const _EmptyStateWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No items found',
        style: TextStyle(
          color: Colors.grey,
          fontSize: context.scaleFont(14),
        ),
      ),
    );
  }
}

/// Optimized menu list with production-ready performance optimizations
class _OptimizedMenuList extends StatelessWidget {
  final List<MenuSectionData> sections;

  const _OptimizedMenuList({
    super.key,
    required this.sections,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: context.scale(14)),
      // WhatsApp-like smooth scrolling physics
      physics: const SmoothScrollPhysics(),
      // Optimized cache extent - balances memory and smoothness
      cacheExtent: 500.0,
      // Critical performance optimizations
      addAutomaticKeepAlives: false, // Don't keep items alive unnecessarily
      addRepaintBoundaries: true, // Isolate repaints for better performance
      addSemanticIndexes: false, // Disable semantic indexes (not needed here)
      // Add bottom padding for better scroll experience
      itemCount: sections.length + 1,
      itemBuilder: (context, index) {
        // Last item is just spacing - const for performance
        if (index == sections.length) {
          return SizedBox(height: context.scaleHeight(100));
        }

        final section = sections[index];
        // Use ObjectKey for better performance than ValueKey with string interpolation
        // RepaintBoundary prevents unnecessary repaints during scroll
        return RepaintBoundary(
          key: ObjectKey(section),
          child: Padding(
            padding: EdgeInsets.only(bottom: context.scaleHeight(5)),
            child: MenuSectionCard(
              title: section.title,
              items: section.items,
            ),
          ),
        );
      },
    );
  }
}
