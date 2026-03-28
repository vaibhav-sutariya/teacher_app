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
import 'package:teachers_app/core/connection/connection_checker.dart' as _i360;
import 'package:teachers_app/core/di/register_module.dart' as _i615;
import 'package:teachers_app/features/my_class/assignment/repositories/assignment_repository.dart'
    as _i773;
import 'package:teachers_app/features/my_class/time_table/bloc/time_table_bloc.dart'
    as _i995;
import 'package:teachers_app/features/my_class/time_table/repositories/time_table_repository.dart'
    as _i114;
import 'package:teachers_app/features/pdf_viewer/repositories/pdf_repository.dart'
    as _i379;
import 'package:teachers_app/features/splash/repositories/splash_repository.dart'
    as _i568;
import 'package:teachers_app/features/splash/repositories/splash_repository_impl.dart'
    as _i243;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.factory<_i568.SplashRepository>(() => _i243.SplashRepositoryImpl());
    gh.factory<_i360.ConnectionChecker>(
      () => _i360.ConnectionCheckerImpl(gh<_i895.Connectivity>()),
    );
    gh.factory<_i379.PdfRepository>(
      () => _i379.PdfRepositoryImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i773.AssignmentRepository>(
      () => _i773.AssignmentRepositoryImpl(),
    );
    gh.lazySingleton<_i114.TimeTableRepository>(
      () => _i114.TimeTableRepositoryImpl(),
    );
    gh.factory<_i995.TimeTableBloc>(
      () => _i995.TimeTableBloc(repository: gh<_i114.TimeTableRepository>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i615.RegisterModule {}
