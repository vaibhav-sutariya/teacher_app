import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../core/widgets/app_loader.dart';
import '../models/video_model.dart';

/// Production-ready video card widget with modern design
/// Optimized for performance with RepaintBoundary and ValueKey
class VideoCard extends StatefulWidget {
  final VideoModel video;
  final VoidCallback? onTap;

  const VideoCard({super.key, required this.video, this.onTap});

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  int? _memCacheWidth;
  int? _memCacheHeight;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Cache MediaQuery calculations to avoid recalculation on every build
    if (_memCacheWidth == null || _memCacheHeight == null) {
      final pixelRatio = MediaQuery.of(context).devicePixelRatio;
      _memCacheWidth = (context.scale(200) * pixelRatio).round();
      _memCacheHeight = (context.scale(200) * pixelRatio).round();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GestureDetector(
        onTapDown: (_) {
          _animationController.forward();
        },
        onTapUp: (_) {
          _animationController.reverse();
          widget.onTap?.call();
        },
        onTapCancel: () {
          _animationController.reverse();
        },
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(context.scale(16)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(context.scale(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Thumbnail with play icon overlay
                  Flexible(child: _buildThumbnail(context)),
                  // Content section
                  _buildContent(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThumbnail(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Thumbnail image
        CachedNetworkImage(
          imageUrl: widget.video.thumbnailUrl ?? '',
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.grey[200]!, Colors.grey[300]!],
              ),
            ),
            child: Center(
              child: AppLoader(strokeWidth: 2.5, color: Colors.grey[500]),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.grey[200]!, Colors.grey[300]!],
              ),
            ),
            child: Icon(
              Icons.video_library_outlined,
              color: Colors.grey[400],
              size: context.scale(40),
            ),
          ),
          memCacheWidth: _memCacheWidth,
          memCacheHeight: _memCacheHeight,
        ),
        // Gradient overlay for better text readability
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: context.scaleHeight(60),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.3),
                ],
              ),
            ),
          ),
        ),
        // Play icon overlay
        Center(
          child: Container(
            padding: EdgeInsets.all(context.scale(12)),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.9),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.play_arrow,
              color: Colors.black,
              size: context.scale(32),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.scale(14)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(context.scale(16)),
          bottomRight: Radius.circular(context.scale(16)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title with modern typography
          Text(
            widget.video.title ?? '',
            style: TextStyle(
              fontSize: context.scaleFont(15),
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1A1A1A),
              letterSpacing: -0.2,
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: context.scaleHeight(6)),
          // Video count with icon
          Row(
            children: [
              Icon(
                Icons.video_library_outlined,
                size: context.scale(14),
                color: Colors.grey[600],
              ),
              SizedBox(width: context.scale(6)),
              Text(
                '${widget.video.videoCount ?? 0} Videos',
                style: TextStyle(
                  fontSize: context.scaleFont(12),
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
