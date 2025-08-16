import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/di/injection_container.dart';
import 'data/repository/auth_repo.dart';
import 'presentation/cubits/delete_account/delete_account_cubit.dart';
import 'presentation/cubits/login/login_cubit.dart';
import 'presentation/cubits/login_info/login_info_cubit.dart';
import 'presentation/cubits/refresh_token/refresh_token_cubit.dart';
import 'presentation/cubits/sentFbCode/send_fb_code_cubit.dart';
import 'presentation/cubits/setNewPassword/set_new_password_cubit.dart';
import 'presentation/cubits/signup/signup_cubit.dart';
import 'presentation/cubits/submitFbCode/submit_fb_code_cubit.dart';
import 'presentation/cubits/verify_code/verify_code_cubit.dart';

void initAuthInjection() async {
  // Repository and data sources will be auto-registered by injectable
  // Cubits are now auto-registered with @injectable annotation
}

List<BlocProvider<Cubit<Object>>> authBlocs() => [
      BlocProvider<LoginInfoCubit>(
        create: (context) => sl<LoginInfoCubit>(),
      ),
      BlocProvider<LoginCubit>(
        create: (context) => sl<LoginCubit>(),
      ),
      BlocProvider<SignupCubit>(
        create: (context) => sl<SignupCubit>(),
      ),
      BlocProvider<VerifyCodeCubit>(
        create: (context) => sl<VerifyCodeCubit>(),
      ),
      BlocProvider<SetNewPasswordCubit>(
        create: (context) => sl<SetNewPasswordCubit>(),
      ),
      BlocProvider<SubmitFbCodeCubit>(
        create: (context) => sl<SubmitFbCodeCubit>(),
      ),
      BlocProvider<SendFbCodeCubit>(
        create: (context) => sl<SendFbCodeCubit>(),
      ),
      BlocProvider<DeleteAccountCubit>(
        create: (context) => sl<DeleteAccountCubit>(),
      ),
      BlocProvider<RefreshTokenCubit>(
        create: (context) => sl<RefreshTokenCubit>(),
      ),
    ];
