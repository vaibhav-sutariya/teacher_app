import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../core/widgets/scroll_aware_bottom_bar_controller.dart';
import '../../../cubit/theme_cubit.dart';
import 'cubit/home_search_cubit.dart';
import 'widgets/home_header.dart';
import 'widgets/home_search_bar.dart';
import 'widgets/quick_menu_overlay.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  final ScrollAwareBottomBarController? bottomBarController;

  const HomePage({super.key, this.bottomBarController});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeSearchCubit(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: Stack(
          children: [
            // Blue Header Background with Bottom Radius
            Container(
              height: context.scaleHeight(
                185,
              ), // Fixed height sufficient to show radius behind menu
              decoration: BoxDecoration(
                color: context.colors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(context.scale(20)),
                  bottomRight: Radius.circular(context.scale(20)),
                ),
              ),
            ),

            // Content
            SafeArea(
              bottom: false,
              child: Column(
                children: [
                  SizedBox(height: context.scaleHeight(5)),
                  // Header
                  const HomeHeader(),
                  SizedBox(height: context.scaleHeight(12)),
                  // Search Bar
                  const HomeSearchBar(),
                  SizedBox(
                    height: context.scaleHeight(12),
                  ), // Consitent spacing
                  // Quick Menu (Expanded to fill bottom)
                  // With margin in QuickMenuOverlay, it will show blue bg on sides
                  Expanded(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        bottomBarController?.handleScroll(notification);
                        // Production-ready: Unfocus search bar when user starts scrolling
                        // This is a common UX pattern (like WhatsApp, Instagram, etc.)
                        // Unfocuses keyboard when user interacts with scrollable content
                        if (notification is ScrollStartNotification) {
                          FocusScope.of(context).unfocus();
                        }
                        return false;
                      },
                      child: const QuickMenuOverlay(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
