import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../core/routes/app_router.gr.dart';
import '../../core/widgets/animated_bottom_bar_wrapper.dart';
import '../../core/widgets/scroll_aware_bottom_bar_controller.dart';
import 'widgets/dashboard_bottom_bar.dart';

@RoutePage()
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late final ScrollAwareBottomBarController _bottomBarController;

  @override
  void initState() {
    super.initState();
    _bottomBarController = ScrollAwareBottomBarController();
  }

  @override
  void dispose() {
    _bottomBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: AutoTabsScaffold(
        extendBody: true,
        routes: [
          HomeRoute(bottomBarController: _bottomBarController),
          const CalendarRoute(),
          const SummaryRoute(),
          const NoticeRoute(),
          const ProfileRoute(),
        ],
        bottomNavigationBuilder: (_, tabsRouter) {
          return ListenableBuilder(
            listenable: _bottomBarController,
            builder: (context, _) {
              return AnimatedBottomBarWrapper(
                isVisible: _bottomBarController.isVisible,
                child: DashboardBottomBar(
                  activeIndex: tabsRouter.activeIndex,
                  onTabSelected: (index) {
                    tabsRouter.setActiveIndex(index);
                    // Reset bottom bar visibility when changing tabs
                    if (index != 0) {
                      _bottomBarController.reset();
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
