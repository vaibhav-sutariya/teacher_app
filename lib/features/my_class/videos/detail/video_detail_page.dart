import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../core/routes/app_router.gr.dart';
import '../../../../core/widgets/app_app_bar.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/widgets/end_of_list_indicator.dart';
import '../../../../core/widgets/error_state.dart';
import '../videos_screen/models/video_item_model.dart';
import '../videos_screen/models/video_model.dart';
import 'bloc/video_detail_bloc.dart';
import 'bloc/video_detail_event.dart';
import 'bloc/video_detail_state.dart';
import 'repositories/video_detail_repository.dart';

/// Production-ready video detail page with 3-column grid
/// Optimized for performance with proper state management using BLoC
@RoutePage()
class VideoDetailPage extends StatelessWidget {
  final VideoModel video;

  const VideoDetailPage({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          VideoDetailBloc(repository: VideoDetailRepository())
            ..add(LoadVideoItemsEvent(videoAlbumId: video.id ?? '')),
      child: _VideoDetailPageContent(video: video),
    );
  }
}

class _VideoDetailPageContent extends StatelessWidget {
  final VideoModel video;

  const _VideoDetailPageContent({required this.video});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppAppBar(
        title: video.title ?? 'Videos',
        profileImageUrl: 'https://i.pravatar.cc/150?u=a042581f4e29026024d',
      ),
      body: BlocSelector<VideoDetailBloc, VideoDetailState, bool>(
        selector: (state) => state.isLoading && state.videos.isEmpty,
        builder: (context, isLoading) {
          if (isLoading) {
            return const Center(child: AppLoader());
          }
          return const _VideoDetailBody();
        },
      ),
    );
  }
}

/// Separated body widget to optimize rebuilds
class _VideoDetailBody extends StatelessWidget {
  const _VideoDetailBody();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<VideoDetailBloc, VideoDetailState, String?>(
      selector: (state) => state.errorMessage,
      builder: (context, errorMessage) {
        if (errorMessage != null) {
          return ErrorState(
            message: errorMessage,
            onRetry: () {
              final videoAlbumId = context
                  .read<VideoDetailBloc>()
                  .state
                  .videoAlbumId;
              context.read<VideoDetailBloc>().add(
                RefreshVideoItemsEvent(videoAlbumId: videoAlbumId),
              );
            },
          );
        }
        return const _VideoDetailContent();
      },
    );
  }
}

/// Main content widget with video grid
/// Optimized for high performance with granular rebuilds using BlocSelector
class _VideoDetailContent extends StatelessWidget {
  const _VideoDetailContent();

  @override
  Widget build(BuildContext context) {
    return _VideoDetailScrollView();
  }
}

/// Scroll view with pagination detection
/// Separated to optimize rebuilds
class _VideoDetailScrollView extends StatelessWidget {
  const _VideoDetailScrollView();

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        // Load more when user scrolls near the bottom (80%)
        if (scrollInfo.metrics.pixels >=
            scrollInfo.metrics.maxScrollExtent * 0.8) {
          // Read BLoC once to avoid multiple reads
          final bloc = context.read<VideoDetailBloc>();
          final state = bloc.state;
          if (state.hasMore && !state.isLoadingMore) {
            bloc.add(const LoadMoreVideoItemsEvent());
          }
        }
        return false;
      },
      child: RefreshIndicator(
        onRefresh: () async {
          final videoAlbumId = context
              .read<VideoDetailBloc>()
              .state
              .videoAlbumId;
          context.read<VideoDetailBloc>().add(
            RefreshVideoItemsEvent(videoAlbumId: videoAlbumId),
          );
          // Wait for the event to complete
          await Future.delayed(const Duration(milliseconds: 600));
        },
        child: CustomScrollView(
          cacheExtent: 500.0,
          slivers: [
            // Video grid - only rebuilds when videos change
            BlocSelector<
              VideoDetailBloc,
              VideoDetailState,
              List<VideoItemModel>
            >(
              selector: (state) => state.videos,
              builder: (context, videos) {
                if (videos.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.video_library_outlined,
                            size: context.scale(64),
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: context.scaleHeight(16)),
                          Text(
                            'No videos found',
                            style: TextStyle(
                              fontSize: context.scaleFont(16),
                              color: Colors.grey[600],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return SliverPadding(
                  padding: EdgeInsets.all(context.scale(4)),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: context.scaleHeight(4),
                      crossAxisSpacing: context.scale(4),
                      childAspectRatio: 1.0,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final video = videos[index];
                        return RepaintBoundary(
                          key: ValueKey('video_item_${video.id}'),
                          child: _VideoItem(
                            key: ValueKey('video_item_widget_${video.id}'),
                            video: video,
                            index: index,
                            totalVideos: videos.length,
                          ),
                        );
                      },
                      childCount: videos.length,
                      // Critical performance optimizations
                      addAutomaticKeepAlives: false,
                      addRepaintBoundaries: true,
                      addSemanticIndexes: false,
                    ),
                  ),
                );
              },
            ),
            // Loading indicator for pagination - only rebuilds when isLoadingMore changes
            BlocSelector<VideoDetailBloc, VideoDetailState, bool>(
              selector: (state) => state.isLoadingMore,
              builder: (context, isLoadingMore) {
                if (isLoadingMore) {
                  return SliverToBoxAdapter(
                    child: RepaintBoundary(
                      child: Padding(
                        padding: EdgeInsets.all(context.scaleHeight(16)),
                        child: const AppLoader(),
                      ),
                    ),
                  );
                }
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              },
            ),
            // End of list indicator - only rebuilds when hasMore changes
            BlocSelector<VideoDetailBloc, VideoDetailState, bool>(
              selector: (state) => !state.hasMore && state.videos.isNotEmpty,
              builder: (context, showEndIndicator) {
                if (showEndIndicator) {
                  return const SliverToBoxAdapter(child: EndOfListIndicator());
                }
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              },
            ),
            // Bottom padding
            SliverToBoxAdapter(
              child: SizedBox(height: context.scaleHeight(20)),
            ),
          ],
        ),
      ),
    );
  }
}

/// Individual video item widget
/// Optimized for performance with cached MediaQuery values
class _VideoItem extends StatefulWidget {
  final VideoItemModel video;
  final int index;
  final int totalVideos;

  const _VideoItem({
    super.key,
    required this.video,
    required this.index,
    required this.totalVideos,
  });

  @override
  State<_VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<_VideoItem> {
  int? _memCacheWidth;
  int? _memCacheHeight;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Cache MediaQuery calculations to avoid recalculation on every build
    if (_memCacheWidth == null || _memCacheHeight == null) {
      final pixelRatio = MediaQuery.of(context).devicePixelRatio;
      _memCacheWidth = (context.scale(150) * pixelRatio).round();
      _memCacheHeight = (context.scale(150) * pixelRatio).round();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Read BLoC state once to avoid multiple reads
        final bloc = context.read<VideoDetailBloc>();
        final state = bloc.state;
        context.router.push(
          VideoViewerRoute(
            videoAlbumId: state.videoAlbumId,
            initialIndex: widget.index,
            videos: state.videos, // Pass videos directly for better performance
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(context.scale(4)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(context.scale(4)),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: widget.video.thumbnailUrl ?? '',
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[200],
                  child: Center(
                    child: AppLoader(strokeWidth: 2.0, color: Colors.grey[400]),
                  ),
                ),

                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[200],
                  child: Icon(
                    Icons.video_library_outlined,
                    color: Colors.grey[400],
                    size: context.scale(24),
                  ),
                ),
                memCacheWidth: _memCacheWidth,
                memCacheHeight: _memCacheHeight,
              ),
              // Play icon overlay
              Center(
                child: Container(
                  padding: EdgeInsets.all(context.scale(8)),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: context.scale(24),
                  ),
                ),
              ),
              // Duration badge
              if (widget.video.duration != null)
                Positioned(
                  bottom: context.scaleHeight(4),
                  right: context.scale(4),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.scale(6),
                      vertical: context.scaleHeight(2),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(context.scale(4)),
                    ),
                    child: Text(
                      widget.video.duration ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: context.scaleFont(10),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
