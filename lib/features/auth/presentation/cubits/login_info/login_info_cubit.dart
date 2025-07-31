import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../../common/dart/base_cubit.dart';
import 'package:lightspot_v1/features/auth/data/repository/auth_repo.dart';
import 'package:lightspot_v1/features/auth/presentation/cubits/refresh_token/refresh_token_cubit.dart';

part 'login_info_state.dart';

@injectable
class LoginInfoCubit extends BaseCubit<LoginInfoState> {
  LoginInfoCubit(this._authRepository) : super(LoginInfoState.initial());
  final AuthRepository _authRepository;

  bool _hasUser = false;
  bool _isLoggedIn = false;
  bool _isGuest = false;
  bool _finishedOnBoarding = false;

  bool get isGuest => _isGuest;
  bool get isLoggedIn => _isLoggedIn;
  bool get finishedOnBoarding => _finishedOnBoarding;

  void init({bool isFirstTimeOpenApp = false}) async {
    final isExpiring = isTokenExpiringSoon();
    if (isExpiring) {
      // TODO: Fix sl import issue
      // await sl<RefreshTokenCubit>().refreshToken();
    }

    if (isFirstTimeOpenApp) {
      emit(LoginInfoState.initial());
    } else {
      emit(LoginInfoState.loading());
    }
    _finishedOnBoarding = _authRepository.finishedOnBoarding();
    _hasUser = _authRepository.hasUser();
    _isLoggedIn = _authRepository.isLoggedIn();
    _isGuest = _isLoggedIn && !_hasUser;
    if (isFirstTimeOpenApp) {
      Future.delayed(const Duration(milliseconds: 2000), () {
        emit(LoginInfoState.loaded());
      });
    } else {
      emit(LoginInfoState.loaded());
    }
  }

  void finishOnBoarding() {
    _authRepository.setFinishedOnBoarding(true);
    init();
  }

  void login() {
    _authRepository.setHasUser(true);
    // _authRepository.setIsLoggedIn(true);
    init();
  }

  void guestLogin() {
    _authRepository.setHasUser(false);
    // _authRepository.setIsLoggedIn(true);
    init();
  }

  void logout() {
    _authRepository.setHasUser(false);
    _authRepository.setFinishedOnBoarding(true);
    // _authRepository.setIsLoggedIn(false);
    // _authRepository.setCachedUser(null);
    // _authRepository.setUserAccessToken(null);
    init();
  }

  bool isTokenExpiringSoon() {
    final token = _authRepository.getUserAccessToken();
    if ((token ?? '').isEmpty) {
      return false;
    }
    final dateTime = _authRepository.getExpiresAt();
    if (dateTime == null ||
        dateTime.isBefore(DateTime.now().add(const Duration(hours: 5)))) {
      return true;
    }
    return false;
  }
}
