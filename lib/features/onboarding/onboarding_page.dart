import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/core/routes/app_router.gr.dart';
import 'package:teachers_app/core/utils/preference_utils.dart';
import 'package:teachers_app/core/widgets/app_primary_button.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import 'models/onboarding_item.dart';
import 'widgets/onboarding_indicator.dart';
import 'widgets/onboarding_slide.dart';

@RoutePage()
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingItem> _items = [
    OnboardingItem(
      icon: Icons.hub, // Placeholder for "Stay Connected" icon
      title: 'Stay Connected',
      description:
          'Real-time updates and seamless communication between teachers, parents, and students.',
    ),
    OnboardingItem(
      icon: Icons.analytics, // Placeholder for "Track Progress" icon
      title: 'Track Progress',
      description:
          'Monitor real-time academic results, attendance trends, and detailed performance reports in one place.',
    ),
    OnboardingItem(
      icon: Icons.directions_bus, // Placeholder for "Smart Management" icon
      title: 'Smart Management',
      description:
          'Track school transport, manage attendance, and stay updated with real-time notifications effortlessly.',
    ),
  ];

  void _onNext() {
    if (_currentIndex < _items.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _finishOnboarding() async {
    await setBool('isOnboarded', true);
    if (mounted) {
      context.router.replace(const LoginRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    // Specific blue color from design approx
    final backgroundColor = context.colors.primary;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation (Skip)
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.scale(16),
                vertical: context.scaleHeight(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (_currentIndex < _items.length - 1)
                    TextButton(
                      onPressed: _finishOnboarding,
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: context.scaleFont(16),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  else
                    const SizedBox(
                      height: 48,
                    ), // Placeholder to keep layout stable
                ],
              ),
            ),

            // Page View
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _items.length,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemBuilder: (context, index) {
                  return OnboardingSlide(item: _items[index]);
                },
              ),
            ),

            // Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_items.length, (index) {
                return OnboardingIndicator(isActive: _currentIndex == index);
              }),
            ),

            SizedBox(height: context.scaleHeight(32)),

            // Bottom Button
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.scale(24),
                vertical: context.scaleHeight(32),
              ),
              child: SizedBox(
                width: double.infinity,
                height: context.scaleHeight(40),
                child: AppPrimaryButton(
                  onPressed: _onNext,
                  color: Colors.white,
                  textColor: context.colors.primary,
                  text: _currentIndex == _items.length - 1
                      ? 'Get Started'
                      : 'Next',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
