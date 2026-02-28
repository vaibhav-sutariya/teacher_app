import 'package:equatable/equatable.dart';

import '../models/remark_model.dart';

/// Remark events
abstract class RemarkEvent extends Equatable {
  const RemarkEvent();

  @override
  List<Object?> get props => [];
}

/// Load remarks event
class LoadRemarksEvent extends RemarkEvent {
  const LoadRemarksEvent();
}

/// Refresh remarks event
class RefreshRemarksEvent extends RemarkEvent {
  const RefreshRemarksEvent();
}

/// Load more remarks event for pagination
class LoadMoreRemarksEvent extends RemarkEvent {
  const LoadMoreRemarksEvent();
}

/// Apply filters event with support for multiple selections
class ApplyFiltersEvent extends RemarkEvent {
  final List<RemarkCategory> categories;
  final List<RemarkType> types;

  const ApplyFiltersEvent({required this.categories, required this.types});

  @override
  List<Object?> get props => [categories, types];
}

/// Clear filters event
class ClearFiltersEvent extends RemarkEvent {
  const ClearFiltersEvent();
}
