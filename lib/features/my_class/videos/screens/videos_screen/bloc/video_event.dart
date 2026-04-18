import 'package:equatable/equatable.dart';

/// Video events
abstract class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object?> get props => [];
}

/// Load video albums (first page)
class LoadVideoEvent extends VideoEvent {
  const LoadVideoEvent();
}

/// Load more video albums (pagination)
class LoadMoreVideoEvent extends VideoEvent {
  const LoadMoreVideoEvent();
}

/// Refresh video albums (reset to first page)
class RefreshVideoEvent extends VideoEvent {
  const RefreshVideoEvent();
}
