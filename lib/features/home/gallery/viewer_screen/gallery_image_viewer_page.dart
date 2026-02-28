import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../core/widgets/app_loader.dart';
import '../gallery_screen/models/gallery_image_model.dart';
import '../gallery_screen/repositories/gallery_repository.dart';

/// Production-ready full-screen image viewer with swiper
/// Optimized for performance with proper state management
@RoutePage()
class GalleryImageViewerPage extends StatefulWidget {
  final String galleryId;
  final int initialIndex;
  final List<GalleryImageModel>? images; // Optional: if provided, use directly

  const GalleryImageViewerPage({
    super.key,
    required this.galleryId,
    required this.initialIndex,
    this.images,
  });

  @override
  State<GalleryImageViewerPage> createState() => _GalleryImageViewerPageState();
}

class _GalleryImageViewerPageState extends State<GalleryImageViewerPage> {
  late PageController _pageController;
  late int _currentIndex;
  bool _showControls = true;
  List<GalleryImageModel>? _images;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);

    // Use provided images or load them
    if (widget.images != null) {
      _images = widget.images;
    } else {
      _loadImages();
    }
  }

  Future<void> _loadImages() async {
    setState(() => _isLoading = true);
    try {
      final repository = MockGalleryRepository();
      // Load all images - for viewer, we load in larger batches
      // In production, this would be handled differently (maybe load all at once or implement pagination in viewer)
      final images = await repository.getGalleryImages(
        galleryId: widget.galleryId,
        page: 1,
        pageSize: 1000, // Load a large batch for viewer
      );
      if (mounted) {
        setState(() {
          _images = images;
          _isLoading = false;
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
        _currentIndex = index;
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
    if (_isLoading || _images == null) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: const AppLoader(color: Colors.white, center: true),
      );
    }

    if (_images!.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            'No images found',
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
          // Image viewer with PageView
          GestureDetector(
            onTap: _toggleControls,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _images!.length,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) {
                final image = _images![index];
                return RepaintBoundary(
                  key: ValueKey('image_viewer_${image.id}_$index'),
                  child: _ImageViewItem(image: image),
                );
              },
            ),
          ),
          // Top bar with counter and back button - only rebuilds when showControls or currentIndex changes
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: _showControls
                ? _TopBar(
                    key: const ValueKey('top_bar'),
                    currentIndex: _currentIndex,
                    totalImages: _images!.length,
                  )
                : const SizedBox.shrink(key: ValueKey('empty')),
          ),
        ],
      ),
    );
  }
}

/// Individual image view item
/// Optimized for performance with cached MediaQuery values
class _ImageViewItem extends StatefulWidget {
  final GalleryImageModel image;

  const _ImageViewItem({required this.image});

  @override
  State<_ImageViewItem> createState() => _ImageViewItemState();
}

class _ImageViewItemState extends State<_ImageViewItem> {
  int? _memCacheWidth;
  int? _memCacheHeight;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Cache MediaQuery calculations to avoid recalculation on every build
    if (_memCacheWidth == null || _memCacheHeight == null) {
      final mediaQuery = MediaQuery.of(context);
      final pixelRatio = mediaQuery.devicePixelRatio;
      _memCacheWidth = (mediaQuery.size.width * pixelRatio).round();
      _memCacheHeight = (mediaQuery.size.height * pixelRatio).round();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InteractiveViewer(
        minScale: 0.5,
        maxScale: 4.0,
        child: CachedNetworkImage(
          imageUrl: widget.image.imageUrl ?? '',
          fit: BoxFit.contain,
          placeholder: (context, url) => Container(
            color: Colors.black,
            child: const Center(child: AppLoader(color: Colors.white)),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.black,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image_not_supported,
                    color: Colors.white.withValues(alpha: 0.5),
                    size: context.scale(64),
                  ),
                  SizedBox(height: context.scaleHeight(16)),
                  Text(
                    'Failed to load image',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: context.scaleFont(16),
                    ),
                  ),
                ],
              ),
            ),
          ),
          memCacheWidth: _memCacheWidth,
          memCacheHeight: _memCacheHeight,
        ),
      ),
    );
  }
}

/// Top bar with image counter and back button
class _TopBar extends StatelessWidget {
  final int currentIndex;
  final int totalImages;

  const _TopBar({
    super.key,
    required this.currentIndex,
    required this.totalImages,
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
            // Image counter
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
                '${currentIndex + 1} / $totalImages',
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
