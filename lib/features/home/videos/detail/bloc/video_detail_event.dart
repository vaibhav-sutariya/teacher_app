import 'package:equatable/equatable.dart';

/// Events for VideoDetailBloc
abstract class VideoDetailEvent extends Equatable {
  const VideoDetailEvent();

  @override
  List<Object?> get props => [];
}

/// Load video items event
class LoadVideoItemsEvent extends VideoDetailEvent {
  final String videoAlbumId;

  const LoadVideoItemsEvent({required this.videoAlbumId});

  @override
  List<Object?> get props => [videoAlbumId];
}

/// Refresh video items event
class RefreshVideoItemsEvent extends VideoDetailEvent {
  final String videoAlbumId;

  const RefreshVideoItemsEvent({required this.videoAlbumId});

  @override
  List<Object?> get props => [videoAlbumId];
}

/// Load more video items event (pagination)
class LoadMoreVideoItemsEvent extends VideoDetailEvent {
  const LoadMoreVideoItemsEvent();
}
