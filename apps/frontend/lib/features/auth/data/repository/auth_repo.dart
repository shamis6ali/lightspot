import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/dart/failure.dart';
import '../models/params/send_fb_code_params.dart';
import '../models/params/submit_fb_code_params.dart';
import '../models/responses/verify_fb_response.dart';
import '../models/user.dart';
import '../dataSource/auth_data_source.dart';
import '../models/params/login_params.dart';
import '../models/params/register_params.dart';
import '../models/params/set_new_password_params.dart';
import '../models/params/verify_params.dart';
import '../models/responses/login_response.dart';
import '../models/responses/register_response.dart';
import '../models/responses/verify_response.dart';

@injectable
class AuthRepository {
  final AuthDataSource dataSource;
  // TODO: Add FirebaseMessaging dependency when available
  // final FirebaseMessaging fireBaseMessaging;

  AuthRepository(this.dataSource);

  /**
   * requests
   */

  Future<Either<Failure, LoginResponse>> login(
      {required LoginParams params}) async {
    try {
      params.fcmToken = await getToken();
      if (kDebugMode) {
        print(params.fcmToken);
      }
      final LoginResponse response = await dataSource.login(params: params);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, LoginResponse>> refreshToken() async {
    try {
      final token = dataSource.getUserAccessToken();
      final LoginResponse response =
          await dataSource.refreshToken(token: token);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, RegisterResponse>> register(
      {required RegisterParams params}) async {
    try {
      final RegisterResponse response =
          await dataSource.register(params: params);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> logout() async {
    try {
      final token = dataSource.getUserAccessToken();
      final response = await dataSource.logout(token: token);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> deleteAccount() async {
    try {
      final token = dataSource.getUserAccessToken();
      final response = await dataSource.deleteAccount(token: token);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, VerifyResponse>> verifyCode(
      {required VerifyParams params}) async {
    try {
      final VerifyResponse response = await dataSource.verifyCode(params: params);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> sendFBCode(
      {required SendFBCodeParams params}) async {
    try {
      final response = await dataSource.sendFBCode(params: params);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, VerifyFBResponse>> submitForgetPasswordCode(
      {required SubmitFBCodeParams params}) async {
    try {
      final VerifyFBResponse response =
          await dataSource.submitForgetPasswordCode(params: params);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> setNewPassword(
      {required SetNewPasswordParams params}) async {
    try {
      final response = await dataSource.setNewPassword(params: params);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  /**
   * local storage
   */

  Future<String> getToken() async {
    try {
      // await fireBaseMessaging.getAPNSToken(); // This line was removed as per the new_code
      return await Future.value(''); // Placeholder for token retrieval
    } catch (e) {
      // await fireBaseMessaging.getAPNSToken(); // This line was removed as per the new_code
      await Future.delayed(const Duration(seconds: 1));
      return await Future.value(''); // Placeholder for token retrieval
    }
  }

  void setCachedUser(User user) {
    dataSource.setCachedUser(user);
  }

  void setUserAccessToken(String token) {
    dataSource.setUserAccessToken(token);
  }

  void setExpiresAt(DateTime expiresAt) {
    dataSource.setExpiresAt(expiresAt);
  }

  void setFinishedOnBoarding(bool finished) {
    dataSource.setFinishedOnBoarding(finished);
  }

  void setHasUser(bool hasUser) {
    dataSource.setHasUser(hasUser);
  }

  void setIsLoggedIn(bool isLoggedIn) {
    dataSource.setIsLoggedIn(isLoggedIn);
  }

  User? getCachedUser() {
    return dataSource.getCachedUser();
  }

  String? getUserAccessToken() {
    return dataSource.getUserAccessToken();
  }

  DateTime? getExpiresAt() {
    return dataSource.getExpiresAt();
  }

  bool finishedOnBoarding() {
    return dataSource.finishedOnBoarding();
  }

  bool hasUser() {
    return dataSource.hasUser();
  }

  bool isLoggedIn() {
    return dataSource.isLoggedIn();
  }
}
