import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure_mapper.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/routes/app_router.gr.dart';
import '../../../../core/utils/preference_utils.dart';
import '../../../../cubit/internet/internet_cubit.dart';
import '../../repositories/splash_repository.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final SplashRepository _splashRepository;
  final InternetCubit _internetCubit;
  late final StreamSubscription internetSub;

  SplashBloc(this._splashRepository, this._internetCubit)
    : super(SplashInitial()) {
    // Start listening to internet status
    internetSub = _internetCubit.stream.listen((status) {
      final connectivity = _internetCubit.state.type;
      if (connectivity != ConnectivityResult.none) {
        add(const SplashInternetRestored());
      }
    });

    // Register event handlers
    on<SplashStartAppFlow>(_onStartAppFlow);
    on<SplashInternetRestored>(_onInternetRestored);
    on<SplashInitializeApp>(_onInitializeApp);
    on<SplashValidateToken>(_onValidateToken);

    // Start the app flow automatically
    add(const SplashStartAppFlow());
  }

  Future<void> _onStartAppFlow(
    SplashStartAppFlow event,
    Emitter<SplashState> emit,
  ) async {
    // Wait for InternetCubit to initialize if it's in the initial state
    if (_internetCubit.state.type == null) {
      await _internetCubit.stream.firstWhere((state) => state.type != null);
    }

    final connectivity = _internetCubit.state.type;
    if (connectivity == ConnectivityResult.none) {
      emit(SplashNoInternet());
      return;
    }

    // If internet is available, validate token and navigate
    emit(SplashChecking());
    await Future.delayed(const Duration(milliseconds: 300));

    final tokenStatus = await _validateTokenInternal(emit);

    switch (tokenStatus) {
      case TokenStatus.valid:
        log('✅ Token valid — go to Dashboard');
        emit(SplashNavigate(const OnboardingRoute()));
        break;
      case TokenStatus.invalid:
      case TokenStatus.init:
        log('⚠️ Token invalid/init — go to Login');
        emit(SplashNavigate(const LoginRoute()));
        break;
      case TokenStatus.error:
        log('🚨 Token validation error');
        emit(SplashError(Failure(type: FailureType.network)));
        break;
    }
  }

  Future<void> _onInternetRestored(
    SplashInternetRestored event,
    Emitter<SplashState> emit,
  ) async {
    emit(SplashChecking());

    await Future.delayed(const Duration(milliseconds: 300));

    final tokenStatus = await _validateTokenInternal(emit);

    switch (tokenStatus) {
      case TokenStatus.valid:
        log('✅ Token valid after internet restore — go to Dashboard');
        emit(SplashNavigate(const OnboardingRoute()));
        break;

      case TokenStatus.invalid:
      case TokenStatus.init:
        log('⚠️ Token invalid/init after restore — go to Login');
        emit(SplashNavigate(const LoginRoute()));
        break;

      case TokenStatus.error:
        log(
          '🚨 Token validation error after restore — show no internet or stay',
        );
        emit(SplashError(Failure(type: FailureType.network)));
        break;
    }
  }

  Future<void> _onInitializeApp(
    SplashInitializeApp event,
    Emitter<SplashState> emit,
  ) async {
    emit(SplashLoading());
    try {
      final tokenStatus = await _validateTokenInternal(emit);

      switch (tokenStatus) {
        case TokenStatus.valid:
          _navigateToDashboard(event.context, emit);
          break;
        case TokenStatus.invalid:
        case TokenStatus.init:
          _navigateToLogin(event.context, emit);
          break;
        case TokenStatus.error:
          _navigateToLogin(event.context, emit);
          break;
      }
    } catch (e, st) {
      log('Splash initialization failed: $e\n$st');
      emit(SplashError(FailureMapper.mapException(e)));
    }
  }

  Future<void> _onValidateToken(
    SplashValidateToken event,
    Emitter<SplashState> emit,
  ) async {
    await _validateTokenInternal(emit);
  }

  /// ✅ Validate token using repository
  Future<TokenStatus> _validateTokenInternal(Emitter<SplashState> emit) async {
    emit(const SplashLoading());

    final isConnected = _internetCubit.state.isConnected;
    if (!isConnected) {
      return TokenStatus.error;
    }
    try {
      final token = getString('refreshToken');
      if (token.isEmpty) {
        log('No token found, navigating to Login');
        return TokenStatus.init;
      }

      final result = await _splashRepository.validateToken(token: token);

      return result.fold(
        (failure) {
          if (failure.type == FailureType.authentication) {
            _clearTokens();
            return TokenStatus.invalid;
          } else if (failure.type == FailureType.network) {
            return TokenStatus.error;
          } else if (failure.type == FailureType.init) {
            return TokenStatus.init;
          } else {
            return TokenStatus.error;
          }
        },
        (_) {
          log('✅ Token valid');
          return TokenStatus.valid;
        },
      );
    } catch (e) {
      log('validateToken error: $e');
      return TokenStatus.error;
    }
  }

  void _navigateToDashboard(BuildContext context, Emitter<SplashState> emit) {
    emit(SplashNavigate(const OnboardingRoute()));
    context.router.replaceAll([const OnboardingRoute()]);
  }

  void _navigateToLogin(BuildContext context, Emitter<SplashState> emit) {
    emit(SplashNavigate(const LoginRoute()));
    context.router.replaceAll([const LoginRoute()]);
  }

  Future<void> _clearTokens() async {
    await Future.wait([
      setString('accessToken', ''),
      setString('refreshToken', ''),
      setString('businessDetailsToken', ''),
      setString('businessName', ''),
    ]);
  }

  @override
  Future<void> close() {
    internetSub.cancel();
    return super.close();
  }
}
