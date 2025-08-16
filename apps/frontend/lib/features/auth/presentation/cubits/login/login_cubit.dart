import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../../common/dart/base_cubit.dart';
import '../../../../../common/dart/request_state.dart';
import '../../../../../common/di/injection_container.dart';
import '../login_info/login_info_cubit.dart';
import '../../../data/models/responses/login_response.dart';
import '../verify_code/verify_code_cubit.dart';
import '../../../data/models/params/login_params.dart';
import '../../../data/repository/auth_repo.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends BaseCubit<LoginState> {
  final AuthRepository _repository;

  LoginCubit(this._repository) : super(LoginState.initial());

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    final params = LoginParams(email: email, password: password);
    
    await callAndFold<LoginResponse>(
      future: _repository.login(params: params),
      onDefaultEmit: (requestState) {
        emit(LoginState(requestState: requestState));
      },
      error: (errorMessage) {
        // TODO: Add proper error handling with UI helper
        print('Login error: $errorMessage');
      },
      success: (response) {
        // TODO: Add proper success handling with UI helper
        print('Login success');
        if (response.user.isVerified) {
          _loginSuccess(response);
        } else {
          // TODO: Add verification bottom sheet
          print('User needs verification');
        }
      },
    );
  }

  void _loginSuccess(LoginResponse response) {
    _repository.setCachedUser(response.user);
    if (response.token != null) {
      _repository.setUserAccessToken(response.token!);
    }
    if (response.expiresAt != null) {
      _repository.setExpiresAt(response.expiresAt!);
    }
    // Set the logged in state to true
    sl<LoginInfoCubit>().login();
  }
}
