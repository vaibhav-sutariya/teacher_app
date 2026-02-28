import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../core/routes/app_router.gr.dart';
import '../../../../core/widgets/app_app_bar.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/widgets/end_of_list_indicator.dart';
import '../../../../core/widgets/error_state.dart';
import 'bloc/video_bloc.dart';
import 'bloc/video_event.dart';
import 'bloc/video_state.dart';
import 'models/video_model.dart';
import 'widgets/video_card.dart';

/// Production-ready videos page
/// Optimized for performance with proper state management using BLoC
@RoutePage()
class VideosPage extends StatelessWidget {
  const VideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VideoBloc(),
      child: const _VideosPageContent(),
    );
  }
}

class _VideosPageContent extends StatelessWidget {
  const _VideosPageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppAppBar(
        title: 'Videos',
        profileImageUrl: 'https://i.pravatar.cc/150?u=a042581f4e29026024d',
      ),
      body: BlocSelector<VideoBloc, VideoState, bool>(
        selector: (state) => state.isLoading && state.videoList.isEmpty,
        builder: (context, isLoading) {
          if (isLoading) {
            return const Center(child: AppLoader());
          }
          return const _VideosBody();
        },
      ),
    );
  }
}

/// Separated body widget to optimize rebuilds
class _VideosBody extends StatelessWidget {
  const _VideosBody();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<VideoBloc, VideoState, String?>(
      selector: (state) => state.errorMessage,
      builder: (context, errorMessage) {
        if (errorMessage != null) {
          return ErrorState(
            message: errorMessage,
            onRetry: () =>
                context.read<VideoBloc>().add(const RefreshVideoEvent()),
          );
        }
        return const _VideosContent();
      },
    );
  }
}

/// Main content widget with video grid and pagination
/// Optimized for high performance with granular rebuilds using BlocSelector
class _VideosContent extends StatelessWidget {
  const _VideosContent();

  @override
  Widget build(BuildContext context) {
    return _VideosScrollView();
  }
}

/// Scroll view with pagination detection
/// Separated to optimize rebuilds
class _VideosScrollView extends StatelessWidget {
  const _VideosScrollView();

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        // Load more when user scrolls near the bottom (80%)
        if (scrollInfo.metrics.pixels >=
            scrollInfo.metrics.maxScrollExtent * 0.8) {
          // Read BLoC once to avoid multiple reads
          final bloc = context.read<VideoBloc>();
          final state = bloc.state;
          if (state.hasMore && !state.isLoadingMore) {
            bloc.add(const LoadMoreVideoEvent());
          }
        }
        return false;
      },
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<VideoBloc>().add(const RefreshVideoEvent());
        },
        child: CustomScrollView(
          cacheExtent: 500.0,
          slivers: [
            // Video grid - only rebuilds when videoList changes
            BlocSelector<VideoBloc, VideoState, List<VideoModel>>(
              selector: (state) => state.videoList,
              builder: (context, videoList) {
                if (videoList.isEmpty) {
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
                            'No video albums found',
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
                  padding: EdgeInsets.all(context.scale(16)),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: context.scaleHeight(16),
                      crossAxisSpacing: context.scale(16),
                      childAspectRatio:
                          0.72, // Slightly adjusted to prevent overflow
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final video = videoList[index];
                        return RepaintBoundary(
                          key: ValueKey(video.id),
                          child: VideoCard(
                            key: ValueKey('video_card_${video.id}'),
                            video: video,
                            onTap: () {
                              context.router.push(
                                VideoDetailRoute(video: video),
                              );
                            },
                          ),
                        );
                      },
                      childCount: videoList.length,
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
            BlocSelector<VideoBloc, VideoState, bool>(
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
            BlocSelector<VideoBloc, VideoState, bool>(
              selector: (state) => !state.hasMore && state.videoList.isNotEmpty,
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
