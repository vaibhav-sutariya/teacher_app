import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';

import 'core/connection/global_connectivity_observer.dart';
import 'core/di/injection.dart';
import 'core/routes/app_router.dart';
import 'core/routes/auth_guard.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/preference_utils.dart';
import 'cubit/internet/internet_cubit.dart';
import 'cubit/locale_cubit.dart';
import 'cubit/theme_cubit.dart';
import 'l10n/l10n.dart';
import 'features/profile/multi_account/bloc/multi_account_bloc.dart';
// 491B6D

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await initHive();
    await configureDependencies();
  } catch (e) {
    // Log initialization error (use logger package in production)
    log('Initialization failed: $e');
  }

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light, // White icons
      statusBarBrightness: Brightness.dark, // White icons (iOS)
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter(authGuard: AuthGuard());
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    context.initResponsive();
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (_) => InternetCubit()
            ..checkConnectivity()
            ..trackConnectivityChange(),
        ),
        BlocProvider<LocaleCubit>(create: (_) => LocaleCubit()),
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
        BlocProvider<MultiAccountBloc>(create: (_) => MultiAccountBloc()),
      ],
      child: BlocBuilder<ThemeCubit, AppTheme>(
        builder: (context, themeState) {
          return BlocBuilder<LocaleCubit, Locale?>(
            buildWhen: (previous, current) =>
                previous?.languageCode != current?.languageCode,
            builder: (context, localeState) {
              return AnnotatedRegion<SystemUiOverlayStyle>(
                value: const SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.light, // White icons
                  statusBarBrightness: Brightness.dark, // White icons (iOS)
                ),
                child: MaterialApp.router(
                  title: 'Teachers App',
                  debugShowCheckedModeBanner: false,
                  theme: themeState.theme,
                  locale: localeState ?? const Locale('en'),
                  supportedLocales: S.supportedLocales,
                  localizationsDelegates: const [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  // routerConfig: _appRouter.config(
                  //   navigatorObservers: () => [autoRouteObserver],
                  // ),
                  routerDelegate: _appRouter.delegate(
                    navigatorObservers: () => [
                      // Add a global observer to handle snackbars
                      GlobalConnectivityObserver(context.read<InternetCubit>()),
                    ],
                  ),
                  routeInformationParser: _appRouter.defaultRouteParser(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
