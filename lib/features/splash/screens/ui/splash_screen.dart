import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/routes/app_router.gr.dart';
import '../../../../core/utils/preference_utils.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../../../../cubit/internet/internet_cubit.dart';
import '../bloc/splash_bloc.dart';
import 'widgets/splash_background.dart';
import 'widgets/splash_content.dart';

@RoutePage()
class SplashPage extends StatefulWidget implements AutoRouteWrapper {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();

  /// ✅ Wrap with BlocProvider
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashBloc(
        sl.get(),
        context.read<InternetCubit>(),
      ), // inject your SplashRepository via sl()
      child: this,
    );
  }
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _entranceController;
  late AnimationController _breathingController;
  late AnimationController _exitController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _breatheAnimation;
  late Animation<double> _exitScaleAnimation;

  @override
  void initState() {
    super.initState();

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _breathingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _exitController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _entranceController, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _entranceController, curve: Curves.easeIn),
    );

    _breatheAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _breathingController, curve: Curves.easeInOut),
    );

    _exitScaleAnimation = Tween<double>(begin: 1.0, end: 30.0).animate(
      CurvedAnimation(parent: _exitController, curve: Curves.easeInOut),
    );

    _entranceController.forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _breathingController.dispose();
    _exitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) async {
        final isOnboarded = getBool('isOnboarded');
        if (state is SplashNavigate) {
          // Add a delay to keep the splash visible for a while
          await Future.delayed(const Duration(seconds: 2));

          // Play expand animation (exit)
          try {
            await _exitController.forward().orCancel;
          } catch (e) {
            // Handle cancellation
          }

          if (!context.mounted) return;

          if (!isOnboarded) {
            context.router.replaceAll([const OnboardingRoute()]);
          } else {
            context.router.replaceAll([state.route]);
          }
        } else if (state is SplashError) {
          state.failure.type == FailureType.network
              ? showFlushbar(
                  context: context,
                  message: 'No Internet Connection',
                )
              : showFlushbar(context: context, message: state.failure.message);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ScaleTransition(
          scale: _exitScaleAnimation,
          child: Stack(
            children: [
              SplashBackground(
                scaleAnimation: _scaleAnimation,
                fadeAnimation: _fadeAnimation,
                breatheAnimation: _breatheAnimation,
                breathingController: _breathingController,
              ),
              SplashContent(
                scaleAnimation: _scaleAnimation,
                fadeAnimation: _fadeAnimation,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
