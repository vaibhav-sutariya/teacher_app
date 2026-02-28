import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../core/widgets/app_loader.dart';
import '../videos_screen/models/video_item_model.dart';
import '../videos_screen/repositories/video_repository.dart';
import 'widgets/custom_video_player.dart';

/// Production-ready full-screen video viewer with swiper
/// Optimized for performance with proper state management
@RoutePage()
class VideoViewerPage extends StatefulWidget {
  final String videoAlbumId;
  final int initialIndex;
  final List<VideoItemModel>? videos; // Optional: if provided, use directly

  const VideoViewerPage({
    super.key,
    required this.videoAlbumId,
    required this.initialIndex,
    this.videos,
  });

  @override
  State<VideoViewerPage> createState() => _VideoViewerPageState();
}

class _VideoViewerPageState extends State<VideoViewerPage> {
  late PageController _pageController;
  late int _currentIndex;
  bool _showControls = true;
  List<VideoItemModel>? _videos;
  bool _isLoading = false;
  final Map<int, bool> _playingVideos = {}; // Track which videos are playing

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);

    // Use provided videos or load them
    if (widget.videos != null) {
      _videos = widget.videos;
      // Auto-play the initial video
      _playingVideos[widget.initialIndex] = true;
    } else {
      _loadVideos();
    }
  }

  Future<void> _loadVideos() async {
    setState(() => _isLoading = true);
    try {
      final repository = MockVideoRepository();
      // Load all videos - for viewer, we load in larger batches
      // In production, this would be handled differently (maybe load all at once or implement pagination in viewer)
      final videos = await repository.getVideos(
        videoAlbumId: widget.videoAlbumId,
        page: 1,
        pageSize: 1000, // Load a large batch for viewer
      );
      if (mounted) {
        setState(() {
          _videos = videos;
          _isLoading = false;
          // Auto-play the initial video after loading
          _playingVideos[widget.initialIndex] = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    // Only update state if index actually changed to prevent unnecessary rebuilds
    if (_currentIndex != index) {
      setState(() {
        // Pause previous video
        _playingVideos[_currentIndex] = false;
        _currentIndex = index;
        // Auto-play current video when swiping
        _playingVideos[index] = true;
      });
    }
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || _videos == null) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: const AppLoader(color: Colors.white, center: true),
      );
    }

    if (_videos!.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            'No videos found',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: context.scaleFont(16),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Video viewer with PageView
          PageView.builder(
            controller: _pageController,
            itemCount: _videos!.length,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) {
              final video = _videos![index];
              final isCurrentVideo = index == _currentIndex;
              final shouldAutoPlay =
                  isCurrentVideo && (_playingVideos[index] ?? false);

              return RepaintBoundary(
                key: ValueKey('video_viewer_${video.id}_$index'),
                child: _VideoViewItem(
                  video: video,
                  autoPlay: shouldAutoPlay,
                  isActive: isCurrentVideo,
                ),
              );
            },
          ),
          // Top bar with counter and back button - only rebuilds when showControls or currentIndex changes
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: _showControls
                ? _TopBar(
                    key: const ValueKey('top_bar'),
                    currentIndex: _currentIndex,
                    totalVideos: _videos!.length,
                  )
                : const SizedBox.shrink(key: ValueKey('empty')),
          ),
        ],
      ),
    );
  }
}

/// Individual video view item
/// Optimized for performance with cached MediaQuery values
class _VideoViewItem extends StatefulWidget {
  final VideoItemModel video;
  final bool autoPlay;
  final bool isActive;

  const _VideoViewItem({
    required this.video,
    this.autoPlay = false,
    this.isActive = false,
  });

  @override
  State<_VideoViewItem> createState() => _VideoViewItemState();
}

class _VideoViewItemState extends State<_VideoViewItem> {
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _isPlaying = widget.autoPlay;
  }

  @override
  void didUpdateWidget(_VideoViewItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update playing state when autoPlay changes
    if (widget.autoPlay != oldWidget.autoPlay) {
      _isPlaying = widget.autoPlay;
    }
  }

  void _togglePlay() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Show video player if playing, otherwise show thumbnail with play button
    if (_isPlaying &&
        widget.video.videoUrl != null &&
        widget.video.videoUrl!.isNotEmpty) {
      return Stack(
        fit: StackFit.expand,
        children: [
          // Video player
          CustomVideoPlayer(
            key: ValueKey('video_player_${widget.video.id}'),
            videoUrl: widget.video.videoUrl!,
            autoPlay: true,
            looping: false,
            showControls: true,
          ),
          // Duration badge overlay
          if (widget.video.duration != null)
            Positioned(
              bottom: context.scaleHeight(20),
              right: context.scale(20),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.scale(12),
                  vertical: context.scaleHeight(6),
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(context.scale(8)),
                ),
                child: Text(
                  widget.video.duration ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: context.scaleFont(14),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      );
    }

    // Show thumbnail with play button
    return GestureDetector(
      onTap: _togglePlay,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Video thumbnail
          CachedNetworkImage(
            imageUrl: widget.video.thumbnailUrl ?? '',
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: Colors.black,
              child: Center(
                child: AppLoader(strokeWidth: 2.5, color: Colors.white),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              color: Colors.black,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.video_library_outlined,
                      color: Colors.white.withValues(alpha: 0.5),
                      size: context.scale(64),
                    ),
                    SizedBox(height: context.scaleHeight(16)),
                    Text(
                      'Failed to load video thumbnail',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: context.scaleFont(16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Play button overlay
          Center(
            child: Container(
              padding: EdgeInsets.all(context.scale(20)),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: context.scale(64),
              ),
            ),
          ),
          // Duration badge
          if (widget.video.duration != null)
            Positioned(
              bottom: context.scaleHeight(20),
              right: context.scale(20),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.scale(12),
                  vertical: context.scaleHeight(6),
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(context.scale(8)),
                ),
                child: Text(
                  widget.video.duration ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: context.scaleFont(14),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Top bar with video counter and back button
class _TopBar extends StatelessWidget {
  final int currentIndex;
  final int totalVideos;

  const _TopBar({
    super.key,
    required this.currentIndex,
    required this.totalVideos,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.scale(16),
          vertical: context.scaleHeight(12),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black.withValues(alpha: 0.7), Colors.transparent],
          ),
        ),
        child: Row(
          children: [
            // Back button
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => context.router.maybePop(),
            ),
            const Spacer(),
            // Video counter
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.scale(12),
                vertical: context.scaleHeight(6),
              ),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(context.scale(20)),
              ),
              child: Text(
                '${currentIndex + 1} / $totalVideos',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: context.scaleFont(14),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
