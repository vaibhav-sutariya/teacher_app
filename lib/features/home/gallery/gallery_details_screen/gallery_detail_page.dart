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
import '../gallery_screen/models/gallery_image_model.dart';
import '../gallery_screen/models/gallery_model.dart';
import 'bloc/gallery_detail_bloc.dart';
import 'bloc/gallery_detail_event.dart';
import 'bloc/gallery_detail_state.dart';
import 'repositories/gallery_detail_repository.dart';

/// Production-ready gallery detail page with 3-column grid
/// Optimized for performance with proper state management using BLoC
@RoutePage()
class GalleryDetailPage extends StatelessWidget {
  final GalleryModel gallery;

  const GalleryDetailPage({super.key, required this.gallery});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GalleryDetailBloc(repository: GalleryDetailRepository())
            ..add(LoadGalleryImagesEvent(galleryId: gallery.id ?? '')),
      child: _GalleryDetailPageContent(gallery: gallery),
    );
  }
}

class _GalleryDetailPageContent extends StatelessWidget {
  final GalleryModel gallery;

  const _GalleryDetailPageContent({required this.gallery});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppAppBar(
        title: gallery.title ?? 'Gallery',
        profileImageUrl: 'https://i.pravatar.cc/150?u=a042581f4e29026024d',
      ),
      body: BlocSelector<GalleryDetailBloc, GalleryDetailState, bool>(
        selector: (state) => state.isLoading && state.images.isEmpty,
        builder: (context, isLoading) {
          if (isLoading) {
            return const Center(child: AppLoader());
          }
          return const _GalleryDetailBody();
        },
      ),
    );
  }
}

/// Separated body widget to optimize rebuilds
class _GalleryDetailBody extends StatelessWidget {
  const _GalleryDetailBody();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<GalleryDetailBloc, GalleryDetailState, String?>(
      selector: (state) => state.errorMessage,
      builder: (context, errorMessage) {
        if (errorMessage != null) {
          return ErrorState(
            message: errorMessage,
            onRetry: () {
              final galleryId = context
                  .read<GalleryDetailBloc>()
                  .state
                  .galleryId;
              context.read<GalleryDetailBloc>().add(
                RefreshGalleryImagesEvent(galleryId: galleryId),
              );
            },
          );
        }
        return const _GalleryDetailContent();
      },
    );
  }
}

/// Main content widget with gallery grid
/// Optimized for high performance with granular rebuilds using BlocSelector
class _GalleryDetailContent extends StatelessWidget {
  const _GalleryDetailContent();

  @override
  Widget build(BuildContext context) {
    return _GalleryDetailScrollView();
  }
}

/// Scroll view with pagination detection
/// Separated to optimize rebuilds
class _GalleryDetailScrollView extends StatelessWidget {
  const _GalleryDetailScrollView();

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        // Load more when user scrolls near the bottom (80%)
        if (scrollInfo.metrics.pixels >=
            scrollInfo.metrics.maxScrollExtent * 0.8) {
          // Read BLoC once to avoid multiple reads
          final bloc = context.read<GalleryDetailBloc>();
          final state = bloc.state;
          if (state.hasMore && !state.isLoadingMore) {
            bloc.add(const LoadMoreGalleryImagesEvent());
          }
        }
        return false;
      },
      child: RefreshIndicator(
        onRefresh: () async {
          final galleryId = context.read<GalleryDetailBloc>().state.galleryId;
          context.read<GalleryDetailBloc>().add(
            RefreshGalleryImagesEvent(galleryId: galleryId),
          );
          // Wait for the event to complete
          await Future.delayed(const Duration(milliseconds: 600));
        },
        child: CustomScrollView(
          cacheExtent: 500.0,
          slivers: [
            // Gallery grid - only rebuilds when images change
            BlocSelector<
              GalleryDetailBloc,
              GalleryDetailState,
              List<GalleryImageModel>
            >(
              selector: (state) => state.images,
              builder: (context, images) {
                if (images.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.photo_outlined,
                            size: context.scale(64),
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: context.scaleHeight(16)),
                          Text(
                            'No images found',
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
                        final image = images[index];
                        return RepaintBoundary(
                          key: ValueKey('gallery_image_${image.id}'),
                          child: _GalleryImageItem(
                            key: ValueKey('gallery_image_item_${image.id}'),
                            image: image,
                            index: index,
                            totalImages: images.length,
                          ),
                        );
                      },
                      childCount: images.length,
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
            BlocSelector<GalleryDetailBloc, GalleryDetailState, bool>(
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
            BlocSelector<GalleryDetailBloc, GalleryDetailState, bool>(
              selector: (state) => !state.hasMore && state.images.isNotEmpty,
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

/// Individual gallery image item widget
/// Optimized for performance with cached MediaQuery values
class _GalleryImageItem extends StatefulWidget {
  final GalleryImageModel image;
  final int index;
  final int totalImages;

  const _GalleryImageItem({
    super.key,
    required this.image,
    required this.index,
    required this.totalImages,
  });

  @override
  State<_GalleryImageItem> createState() => _GalleryImageItemState();
}

class _GalleryImageItemState extends State<_GalleryImageItem> {
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
        final bloc = context.read<GalleryDetailBloc>();
        final state = bloc.state;
        context.router.push(
          GalleryImageViewerRoute(
            galleryId: state.galleryId,
            initialIndex: widget.index,
            images: state.images, // Pass images directly for better performance
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
          child: CachedNetworkImage(
            imageUrl: widget.image.thumbnailUrl ?? widget.image.imageUrl ?? '',
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: Colors.grey[200],
              child: AppLoader(strokeWidth: 2.0, color: Colors.grey[400]),
            ),
            errorWidget: (context, url, error) => Container(
              color: Colors.grey[200],
              child: Icon(
                Icons.image_not_supported,
                color: Colors.grey[400],
                size: context.scale(24),
              ),
            ),
            memCacheWidth: _memCacheWidth,
            memCacheHeight: _memCacheHeight,
          ),
        ),
      ),
    );
  }
}
