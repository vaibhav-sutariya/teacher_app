// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:teachers_app/core/connection/connection_checker.dart' as _i635;
import 'package:teachers_app/core/di/register_module.dart' as _i981;
import 'package:teachers_app/features/pdf_viewer/repositories/pdf_repository.dart'
    as _i178;
import 'package:teachers_app/features/splash/repositories/splash_repository.dart'
    as _i452;
import 'package:teachers_app/features/splash/repositories/splash_repository_impl.dart'
    as _i119;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.factory<_i635.ConnectionChecker>(
      () => _i635.ConnectionCheckerImpl(gh<_i895.Connectivity>()),
    );
    gh.factory<_i178.PdfRepository>(
      () => _i178.PdfRepositoryImpl(gh<_i361.Dio>()),
    );
    gh.factory<_i452.SplashRepository>(() => _i119.SplashRepositoryImpl());
    return this;
  }
}

class _$RegisterModule extends _i981.RegisterModule {}
