import 'package:injectable/injectable.dart';

import '../../../../common/data/app_preferences.dart';
import '../../../../common/util/api_basehelper.dart';
import '../models/params/login_params.dart';
import '../models/params/register_params.dart';
import '../models/params/send_fb_code_params.dart';
import '../models/params/set_new_password_params.dart';
import '../models/params/submit_fb_code_params.dart';
import '../models/params/verify_params.dart';
import '../models/responses/login_response.dart';
import '../models/responses/register_response.dart';
import '../models/responses/verify_response.dart';
import '../models/responses/verify_fb_response.dart';
import '../models/user.dart';

const String deleteAccountApi = '/auth/delete-account';
const String refreshTokenApi = '/auth/refresh';
const String loginApi = '/auth/login';
const String logoutApi = '/auth/log_out';
const String registerApi = '/auth/register';
const String verifyApi = '/auth/verify_phone';
const String sendCodeApi = '/auth/send-code';
const String submitForgetPasswordCodeApi = '/auth/submit-code';
const String setNewPasswordApi = '/auth/set-new-password';

abstract class AuthDataSource {
  Future<LoginResponse> login({required LoginParams params});
  Future<RegisterResponse> register({required RegisterParams params});
  Future<VerifyResponse> verifyCode({required VerifyParams params});
  Future<Map<String, dynamic>> logout({required String? token});
  Future<Map<String, dynamic>> sendFBCode({required SendFBCodeParams params});
  Future<VerifyFBResponse> submitForgetPasswordCode(
      {required SubmitFBCodeParams params});
  Future<LoginResponse> refreshToken({String? token});

  Future<Map<String, dynamic>> setNewPassword({required SetNewPasswordParams params});

  Future<Map<String, dynamic>> deleteAccount({required String? token});

  String? getUserAccessToken();
  DateTime? getExpiresAt();

  User? getCachedUser();
  bool hasUser();
  bool isLoggedIn();
  bool finishedOnBoarding();

  void setUserAccessToken(String? token);
  void setExpiresAt(DateTime? time);

  void setCachedUser(User? user);
  void setHasUser(bool hasUser);
  void setIsLoggedIn(bool isLoggedIn);
  void setFinishedOnBoarding(bool finishedOnboarding);
}

@injectable
class AuthDataSourceImpl extends AuthDataSource {
  final ApiBaseHelper helper;

  AuthDataSourceImpl(this.helper);

  @override
  Future<LoginResponse> login({required LoginParams params}) async {
    try {
      final LoginResponse data = LoginResponse.fromJson(
          await helper.post(url: loginApi, body: params.toJson()));
      return data;
    } catch (e) {
      print('$e');
      rethrow;
    }
  }

  @override
  Future<LoginResponse> refreshToken({String? token}) async {
    try {
      final LoginResponse data = LoginResponse.fromJson(
          await helper.post(url: refreshTokenApi, body: {}, token: token));
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> logout({required String? token}) async {
    try {
      final Map<String, dynamic> data = await helper.post(url: logoutApi, body: {}, token: token);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> deleteAccount({required String? token}) async {
    try {
      final Map<String, dynamic> data = await helper.delete(url: deleteAccountApi, token: token);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> sendFBCode({required SendFBCodeParams params}) async {
    try {
      final Map<String, dynamic> data = await helper.post(url: sendCodeApi, body: params.toJson());
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<VerifyFBResponse> submitForgetPasswordCode(
      {required SubmitFBCodeParams params}) async {
    try {
      final VerifyFBResponse data = VerifyFBResponse.fromJson(await helper.post(
          url: submitForgetPasswordCodeApi, body: params.toJson()));
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> setNewPassword(
      {required SetNewPasswordParams params}) async {
    try {
      final Map<String, dynamic> data = await helper.post(
          url: setNewPasswordApi, body: params.toJson(), token: params.token);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<RegisterResponse> register({required RegisterParams params}) async {
    try {
      final RegisterResponse data = RegisterResponse.fromJson(
          await helper.post(url: registerApi, body: params.toJson()));
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<VerifyResponse> verifyCode({required VerifyParams params}) async {
    try {
      final VerifyResponse data = VerifyResponse.fromJson(
          await helper.post(url: verifyApi, body: params.toJson()));
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void setUserAccessToken(String? token) {
    if (token != null) {
      AppPreferences.setAccessToken(token);
    }
  }

  @override
  String? getUserAccessToken() {
    return AppPreferences.getAccessToken();
  }

  @override
  void setExpiresAt(DateTime? time) {
    if (time != null) {
      AppPreferences.setExpiresAt(time);
    }
  }

  @override
  DateTime? getExpiresAt() {
    return AppPreferences.getExpiresAt();
  }

  @override
  User? getCachedUser() {
    final userString = AppPreferences.getCachedUser();
    return userString != null ? User.fromString(userString) : null;
  }

  @override
  void setCachedUser(User? user) {
    if (user != null) {
      AppPreferences.setCachedUser(user.toUserString());
    }
  }

  @override
  bool hasUser() => AppPreferences.getHasUser();
  
  @override
  void setHasUser(bool hasUser) => AppPreferences.setHasUser(hasUser);

  @override
  bool isLoggedIn() => AppPreferences.getIsLoggedIn();
  
  @override
  void setIsLoggedIn(bool isLoggedIn) => AppPreferences.setIsLoggedIn(isLoggedIn);

  @override
  bool finishedOnBoarding() => AppPreferences.getFinishedOnboarding();
  
  @override
  void setFinishedOnBoarding(bool finishedOnboarding) => 
      AppPreferences.setFinishedOnboarding(finishedOnboarding);
}
