import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../helpers/extensions/responsive_extensions.dart';
import '../../cubit/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/profile/multi_account/bloc/multi_account_bloc.dart';
import '../../features/profile/multi_account/bloc/multi_account_state.dart';
import '../../features/profile/multi_account/widgets/multi_account_bottom_sheet.dart';

/// Production-ready reusable AppBar widget
/// Features:
/// - Back button on the left
/// - Screen title in the center
/// - Rounded profile image on the right
/// - Fully customizable and responsive
class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? profileImageUrl;
  final VoidCallback? onBackPressed;
  final VoidCallback? onProfilePressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool automaticallyImplyLeading;
  final List<Widget>? actions;
  final double? elevation;
  final bool showBackButton;

  const AppAppBar({
    super.key,
    required this.title,
    this.profileImageUrl,
    this.onBackPressed,
    this.onProfilePressed,
    this.backgroundColor,
    this.foregroundColor,
    this.automaticallyImplyLeading = false,
    this.actions,
    this.elevation = 0,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? context.colors.primary;
    final fgColor = foregroundColor ?? Colors.white;

    return AppBar(
      backgroundColor: bgColor,
      foregroundColor: fgColor,
      elevation: elevation,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: showBackButton ? _buildBackButton(context, fgColor) : null,
      title: Text(
        title,
        style: TextStyle(
          fontSize: context.scaleFont(18),
          fontWeight: FontWeight.bold,
          color: fgColor,
        ),
      ),
      titleSpacing: context.scale(16),
      // centerTitle: true,
      actions: [...?actions, const _AppBarProfileIcon()],
    );
  }

  Widget _buildBackButton(BuildContext context, Color iconColor) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: iconColor,
        size: context.scale(20),
      ),
      onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(
        minWidth: context.scale(40),
        minHeight: context.scale(40),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarProfileIcon extends StatelessWidget {
  const _AppBarProfileIcon();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MultiAccountBloc, MultiAccountState>(
      builder: (context, state) {
        final account = state.activeAccount;
        // Default to white icon if background is primary, dark if surface
        final iconColor = context.colors.primary == context.colors.background
            ? context.colors.primary
            : Colors.white;

        return GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => const MultiAccountBottomSheet(),
            );
          },
          child: Container(
            margin: EdgeInsets.only(right: context.scale(12)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(context.scale(20)),
              child: account?.profileImageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: account!.profileImageUrl!,
                      width: context.scale(40),
                      height: context.scale(40),
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: context.scale(40),
                        height: context.scale(40),
                        color: Colors.grey[300],
                        child: Icon(
                          Icons.person,
                          color: Colors.grey[600],
                          size: context.scale(20),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: context.scale(40),
                        height: context.scale(40),
                        color: Colors.grey[300],
                        child: Icon(
                          Icons.person,
                          color: Colors.grey[600],
                          size: context.scale(20),
                        ),
                      ),
                    )
                  : Container(
                      width: context.scale(40),
                      height: context.scale(40),
                      decoration: BoxDecoration(
                        color: iconColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(context.scale(20)),
                      ),
                      child: Icon(
                        Icons.person,
                        color: iconColor,
                        size: context.scale(20),
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
