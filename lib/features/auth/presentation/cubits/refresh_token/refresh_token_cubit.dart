import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../../common/dart/base_cubit.dart';
import '../../../../../common/dart/request_state.dart';
import 'package:lightspot_v1/features/auth/data/models/responses/login_response.dart';
import 'package:lightspot_v1/features/auth/data/repository/auth_repo.dart';

part 'refresh_token_state.dart';

@injectable
class RefreshTokenCubit extends BaseCubit<RefreshTokenState> {
  RefreshTokenCubit(this._repository) : super(RefreshTokenState.initial());
  final AuthRepository _repository;

  Future<void> refreshToken() async {
    await callAndFold<LoginResponse>(
      future: _repository.refreshToken(),
      onDefaultEmit: (requestState) {
        emit(RefreshTokenState(requestState: requestState));
      },
      error: (errorMessage) {
        String message = 'Please try again later';
        if (errorMessage.isNotEmpty) {
          message = errorMessage;
        }
        // TODO: Add proper error handling with UI helper
        print('Refresh token error: $message');
      },
      success: (response) {
        _repository.setCachedUser(response.user);
        // _repository.setUserAccessToken(response.token);
        // _repository.setExpiresAt(response.expiresAt);
        // TODO: Add proper success handling with UI helper
        print('Refresh token success');
      },
    );
  }
}
