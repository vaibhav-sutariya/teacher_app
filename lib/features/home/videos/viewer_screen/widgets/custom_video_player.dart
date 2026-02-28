import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../core/widgets/app_loader.dart';

/// Production-ready custom video player widget
/// Optimized for performance with proper lifecycle management
class CustomVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final bool autoPlay;
  final bool looping;
  final bool showControls;

  const CustomVideoPlayer({
    super.key,
    required this.videoUrl,
    this.autoPlay = false,
    this.looping = false,
    this.showControls = true,
  });

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _isInitialized = false;
  bool _hasError = false;
  String? _errorMessage;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  @override
  void didUpdateWidget(CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reinitialize if video URL changed
    if (oldWidget.videoUrl != widget.videoUrl) {
      _disposePlayer();
      _initializePlayer();
    } else if (oldWidget.autoPlay != widget.autoPlay &&
        _chewieController != null) {
      // Update autoPlay state
      if (widget.autoPlay) {
        _chewieController!.play();
      } else {
        _chewieController!.pause();
      }
    }
  }

  void _disposePlayer() {
    _videoPlayerController?.removeListener(_videoPlayerListener);
    _chewieController?.dispose();
    _videoPlayerController?.dispose();
    _chewieController = null;
    _videoPlayerController = null;
    _isInitialized = false;
    _hasError = false;
    _isLoading = false;
    _errorMessage = null;
  }

  Future<void> _initializePlayer() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
        _hasError = false;
        _errorMessage = null;
      });
    }

    // Validate URL
    if (widget.videoUrl.isEmpty) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _isLoading = false;
          _errorMessage = 'Video URL is empty';
        });
      }
      return;
    }

    Uri? videoUri;
    try {
      videoUri = Uri.parse(widget.videoUrl);
      if (!videoUri.hasScheme ||
          (!videoUri.isScheme('http') && !videoUri.isScheme('https'))) {
        throw FormatException('Invalid video URL scheme');
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _isLoading = false;
          _errorMessage = 'Invalid video URL format: ${e.toString()}';
        });
      }
      return;
    }

    try {
      // Dispose previous controller if exists
      _videoPlayerController?.removeListener(_videoPlayerListener);
      _videoPlayerController?.dispose();

      _videoPlayerController = VideoPlayerController.networkUrl(
        videoUri,
        httpHeaders: {
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
        },
      );

      // Add error listener
      _videoPlayerController!.addListener(_videoPlayerListener);

      // Initialize with timeout
      await _videoPlayerController!.initialize().timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception('Video initialization timeout');
        },
      );

      if (mounted && _videoPlayerController!.value.isInitialized) {
        final aspectRatio = _videoPlayerController!.value.aspectRatio;

        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController!,
          autoPlay: widget.autoPlay,
          looping: widget.looping,
          showControls: widget.showControls,
          aspectRatio: aspectRatio.isFinite && aspectRatio > 0
              ? aspectRatio
              : 16 / 9,
          allowFullScreen: true,
          allowMuting: true,
          allowPlaybackSpeedChanging: true,
          materialProgressColors: ChewieProgressColors(
            playedColor: Colors.red,
            handleColor: Colors.red,
            backgroundColor: Colors.grey,
            bufferedColor: Colors.lightGreen,
          ),
          placeholder: Container(
            color: Colors.black,
            child: const Center(child: AppLoader(color: Colors.white)),
          ),
          errorBuilder: (context, errorMessage) {
            return _buildErrorWidget(errorMessage);
          },
        );

        if (mounted) {
          setState(() {
            _isInitialized = true;
            _hasError = false;
            _isLoading = false;
            _errorMessage = null;
          });
        }
      } else {
        throw Exception('Video player failed to initialize');
      }
    } on PlatformException catch (e) {
      // Handle platform-specific errors (like channel errors)
      if (mounted) {
        String errorMsg = 'Video player initialization failed';
        if (e.code == 'channel-error') {
          errorMsg =
              'Video player plugin error. Please:\n1. Stop the app completely\n2. Run: flutter clean\n3. Run: flutter pub get\n4. Rebuild and restart the app';
        } else if (e.message != null && e.message!.isNotEmpty) {
          errorMsg = e.message!;
        } else {
          errorMsg = 'Platform error: ${e.code}';
        }

        setState(() {
          _hasError = true;
          _isInitialized = false;
          _isLoading = false;
          _errorMessage = errorMsg;
        });
      }
      _videoPlayerController?.removeListener(_videoPlayerListener);
      _videoPlayerController?.dispose();
      _videoPlayerController = null;
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _isInitialized = false;
          _isLoading = false;
          _errorMessage = e.toString();
        });
      }
      _videoPlayerController?.removeListener(_videoPlayerListener);
      _videoPlayerController?.dispose();
      _videoPlayerController = null;
    }
  }

  void _videoPlayerListener() {
    if (_videoPlayerController != null) {
      if (_videoPlayerController!.value.hasError) {
        if (mounted) {
          setState(() {
            _hasError = true;
            _errorMessage =
                _videoPlayerController!.value.errorDescription ??
                'Unknown error';
          });
        }
      }
    }
  }

  Widget _buildErrorWidget(String errorMessage) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.white.withValues(alpha: 0.7),
              size: context.scale(48),
            ),
            SizedBox(height: context.scaleHeight(12)),
            Text(
              'Error loading video',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: context.scaleFont(14),
              ),
            ),
            SizedBox(height: context.scaleHeight(8)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.scale(16)),
              child: Text(
                errorMessage,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: context.scaleFont(12),
                ),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: context.scaleHeight(16)),
            ElevatedButton.icon(
              onPressed: _initializePlayer,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _disposePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.white.withValues(alpha: 0.7),
                size: context.scale(64),
              ),
              SizedBox(height: context.scaleHeight(16)),
              Text(
                'Failed to load video',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: context.scaleFont(16),
                ),
              ),
              SizedBox(height: context.scaleHeight(8)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.scale(16)),
                child: Text(
                  widget.videoUrl,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: context.scaleFont(12),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (_errorMessage != null) ...[
                SizedBox(height: context.scaleHeight(12)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.scale(16)),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: context.scaleFont(12),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
              SizedBox(height: context.scaleHeight(16)),
              ElevatedButton.icon(
                onPressed: _initializePlayer,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_isLoading || !_isInitialized || _chewieController == null) {
      return Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppLoader(color: Colors.white),
              SizedBox(height: context.scaleHeight(16)),
              Text(
                'Loading video...',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: context.scaleFont(14),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      color: Colors.black,
      width: double.infinity,
      height: double.infinity,
      child: Chewie(controller: _chewieController!),
    );
  }
}
