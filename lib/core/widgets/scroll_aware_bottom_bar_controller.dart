import 'package:flutter/material.dart';

/// Controller to manage bottom bar visibility based on scroll direction
/// Optimized for performance with minimal rebuilds
class ScrollAwareBottomBarController extends ChangeNotifier {
  bool _isVisible = true;
  double _lastScrollOffset = 0;
  static const double _scrollThreshold =
      10.0; // Minimum scroll to trigger hide/show

  bool get isVisible => _isVisible;

  /// Call this method from a scroll listener
  /// Returns true if visibility changed, false otherwise
  bool handleScroll(ScrollNotification notification) {
    if (notification is! UserScrollNotification &&
        notification is! ScrollUpdateNotification) {
      return false;
    }

    final currentOffset = notification.metrics.pixels;
    final maxScroll = notification.metrics.maxScrollExtent;

    // Don't hide at the very top or bottom
    if (currentOffset <= 0 || currentOffset >= maxScroll) {
      if (!_isVisible) {
        _isVisible = true;
        notifyListeners();
        return true;
      }
      return false;
    }

    final scrollDelta = currentOffset - _lastScrollOffset;

    // Only trigger if scroll delta exceeds threshold
    if (scrollDelta.abs() < _scrollThreshold) {
      return false;
    }

    bool shouldBeVisible;
    if (scrollDelta > 0) {
      // Scrolling down - hide
      shouldBeVisible = false;
    } else {
      // Scrolling up - show
      shouldBeVisible = true;
    }

    _lastScrollOffset = currentOffset;

    if (_isVisible != shouldBeVisible) {
      _isVisible = shouldBeVisible;
      notifyListeners();
      return true;
    }

    return false;
  }

  /// Reset to visible state
  void reset() {
    if (!_isVisible) {
      _isVisible = true;
      _lastScrollOffset = 0;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
