// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/dataSource/auth_data_source.dart' as _i753;
import '../../features/auth/data/repository/auth_repo.dart' as _i355;
import '../../features/auth/presentation/cubits/delete_account/delete_account_cubit.dart'
    as _i882;
import '../../features/auth/presentation/cubits/login/login_cubit.dart'
    as _i1019;
import '../../features/auth/presentation/cubits/login_info/login_info_cubit.dart'
    as _i330;
import '../../features/auth/presentation/cubits/refresh_token/refresh_token_cubit.dart'
    as _i460;
import '../../features/auth/presentation/cubits/sentFbCode/send_fb_code_cubit.dart'
    as _i313;
import '../../features/auth/presentation/cubits/setNewPassword/set_new_password_cubit.dart'
    as _i344;
import '../../features/auth/presentation/cubits/signup/signup_cubit.dart'
    as _i24;
import '../../features/auth/presentation/cubits/submitFbCode/submit_fb_code_cubit.dart'
    as _i531;
import '../../features/auth/presentation/cubits/verify_code/verify_code_cubit.dart'
    as _i137;
import '../../features/bottom_navigation/cubits/navigation_cubit.dart' as _i935;
import '../data/app_preferences.dart' as _i118;
import '../util/api_basehelper.dart' as _i452;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i118.AppPreferences>(() => _i118.AppPreferences());
    gh.factory<_i452.ApiBaseHelper>(() => _i452.ApiBaseHelper());
    gh.singleton<_i935.NavigationCubit>(() => _i935.NavigationCubit());
    gh.factory<_i355.AuthRepository>(
      () => _i355.AuthRepository(gh<_i753.AuthDataSource>()),
    );
    gh.factory<_i753.AuthDataSourceImpl>(
      () => _i753.AuthDataSourceImpl(gh<_i452.ApiBaseHelper>()),
    );
    gh.factory<_i753.AuthDataSource>(
      () => gh<_i753.AuthDataSourceImpl>(),
    );
    gh.factory<_i460.RefreshTokenCubit>(
      () => _i460.RefreshTokenCubit(gh<_i355.AuthRepository>()),
    );
    gh.factory<_i882.DeleteAccountCubit>(
      () => _i882.DeleteAccountCubit(gh<_i355.AuthRepository>()),
    );
    gh.factory<_i24.SignupCubit>(
      () => _i24.SignupCubit(gh<_i355.AuthRepository>()),
    );
    gh.factory<_i344.SetNewPasswordCubit>(
      () => _i344.SetNewPasswordCubit(gh<_i355.AuthRepository>()),
    );
    gh.factory<_i137.VerifyCodeCubit>(
      () => _i137.VerifyCodeCubit(gh<_i355.AuthRepository>()),
    );
    gh.factory<_i313.SendFbCodeCubit>(
      () => _i313.SendFbCodeCubit(gh<_i355.AuthRepository>()),
    );
    gh.factory<_i531.SubmitFbCodeCubit>(
      () => _i531.SubmitFbCodeCubit(gh<_i355.AuthRepository>()),
    );
    gh.factory<_i1019.LoginCubit>(
      () => _i1019.LoginCubit(gh<_i355.AuthRepository>()),
    );
    gh.factory<_i330.LoginInfoCubit>(
      () => _i330.LoginInfoCubit(gh<_i355.AuthRepository>()),
    );
    return this;
  }
}
