part of 'splash_bloc.dart';

abstract class SplashEvent {
  const SplashEvent();
}

class SplashInitializeApp extends SplashEvent {
  final BuildContext context;
  const SplashInitializeApp(this.context);
}

class SplashValidateToken extends SplashEvent {
  const SplashValidateToken();
}

class SplashInternetRestored extends SplashEvent {
  const SplashInternetRestored();
}

class SplashStartAppFlow extends SplashEvent {
  const SplashStartAppFlow();
}
