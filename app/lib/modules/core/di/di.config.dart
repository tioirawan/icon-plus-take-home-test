// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:icon_plus_app/modules/auth/data/datasources/auth_remote_data_source.dart'
    as _i243;
import 'package:icon_plus_app/modules/auth/data/repositories/auth_repository_impl.dart'
    as _i133;
import 'package:icon_plus_app/modules/auth/data/repositories/token_repository_impl.dart'
    as _i444;
import 'package:icon_plus_app/modules/auth/domain/repositories/auth_repository.dart'
    as _i331;
import 'package:icon_plus_app/modules/auth/domain/repositories/token_repository.dart'
    as _i743;
import 'package:icon_plus_app/modules/auth/domain/usecases/login_usecase.dart'
    as _i337;
import 'package:icon_plus_app/modules/auth/domain/usecases/register_usecase.dart'
    as _i887;
import 'package:icon_plus_app/modules/auth/presentation/blocs/auth_bloc/auth_bloc.dart'
    as _i667;
import 'package:icon_plus_app/modules/auth/presentation/blocs/login_bloc/login_bloc.dart'
    as _i87;
import 'package:icon_plus_app/modules/auth/presentation/blocs/register_bloc/register_bloc.dart'
    as _i598;
import 'package:icon_plus_app/modules/core/di/register_module.dart' as _i290;
import 'package:icon_plus_app/modules/profile/data/datasources/profile_remote_data_source.dart'
    as _i203;
import 'package:icon_plus_app/modules/profile/data/repositories/profile_repository_impl.dart'
    as _i471;
import 'package:icon_plus_app/modules/profile/domain/repositories/profile_repository.dart'
    as _i589;
import 'package:icon_plus_app/modules/profile/domain/usecases/change_password_usecase.dart'
    as _i343;
import 'package:icon_plus_app/modules/profile/domain/usecases/get_profile_usecase.dart'
    as _i920;
import 'package:icon_plus_app/modules/profile/domain/usecases/logout_usecase.dart'
    as _i1025;
import 'package:icon_plus_app/modules/profile/domain/usecases/update_profile_usecase.dart'
    as _i670;
import 'package:icon_plus_app/modules/profile/presentation/blocs/change_password_bloc/change_password_bloc.dart'
    as _i322;
import 'package:icon_plus_app/modules/profile/presentation/blocs/edit_profile_bloc/edit_profile_bloc.dart'
    as _i451;
import 'package:icon_plus_app/modules/profile/presentation/blocs/profile_bloc/profile_bloc.dart'
    as _i458;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => registerModule.secureStorage,
    );
    gh.lazySingleton<_i743.TokenRepository>(
      () => _i444.TokenRepositoryImpl(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => registerModule.baseDio,
      instanceName: 'baseDio',
    );
    gh.lazySingleton<_i243.AuthRemoteDataSource>(
      () => _i243.AuthRemoteDataSourceImpl(
        gh<_i361.Dio>(instanceName: 'baseDio'),
      ),
    );
    gh.lazySingleton<_i331.AuthRepository>(
      () => _i133.AuthRepositoryImpl(gh<_i243.AuthRemoteDataSource>()),
    );
    gh.singleton<_i667.AuthBloc>(
      () => _i667.AuthBloc(gh<_i743.TokenRepository>()),
    );
    gh.factory<_i337.LoginUseCase>(
      () => _i337.LoginUseCase(gh<_i331.AuthRepository>()),
    );
    gh.factory<_i887.RegisterUseCase>(
      () => _i887.RegisterUseCase(gh<_i331.AuthRepository>()),
    );
    gh.factory<_i598.RegisterBloc>(
      () => _i598.RegisterBloc(
        gh<_i887.RegisterUseCase>(),
        gh<_i743.TokenRepository>(),
      ),
    );
    gh.factory<_i87.LoginBloc>(
      () =>
          _i87.LoginBloc(gh<_i337.LoginUseCase>(), gh<_i743.TokenRepository>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => registerModule.dio(
        gh<_i361.Dio>(instanceName: 'baseDio'),
        gh<_i743.TokenRepository>(),
        gh<_i667.AuthBloc>(),
      ),
    );
    gh.lazySingleton<_i203.ProfileRemoteDataSource>(
      () => _i203.ProfileRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i589.ProfileRepository>(
      () => _i471.ProfileRepositoryImpl(gh<_i203.ProfileRemoteDataSource>()),
    );
    gh.factory<_i670.UpdateProfileUseCase>(
      () => _i670.UpdateProfileUseCase(gh<_i589.ProfileRepository>()),
    );
    gh.factory<_i1025.LogoutUseCase>(
      () => _i1025.LogoutUseCase(gh<_i589.ProfileRepository>()),
    );
    gh.factory<_i920.GetProfileUseCase>(
      () => _i920.GetProfileUseCase(gh<_i589.ProfileRepository>()),
    );
    gh.factory<_i343.ChangePasswordUseCase>(
      () => _i343.ChangePasswordUseCase(gh<_i589.ProfileRepository>()),
    );
    gh.factory<_i451.EditProfileBloc>(
      () => _i451.EditProfileBloc(gh<_i670.UpdateProfileUseCase>()),
    );
    gh.factory<_i322.ChangePasswordBloc>(
      () => _i322.ChangePasswordBloc(gh<_i343.ChangePasswordUseCase>()),
    );
    gh.factory<_i458.ProfileBloc>(
      () => _i458.ProfileBloc(
        gh<_i920.GetProfileUseCase>(),
        gh<_i1025.LogoutUseCase>(),
        gh<_i667.AuthBloc>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i290.RegisterModule {}
