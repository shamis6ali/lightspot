import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../../common/dart/base_cubit.dart';
import '../../../../../common/dart/request_state.dart';
import 'package:lightspot_v1/features/auth/data/models/params/set_new_password_params.dart';
import 'package:lightspot_v1/features/auth/data/repository/auth_repo.dart';

part 'set_new_password_state.dart';

@injectable
class SetNewPasswordCubit extends BaseCubit<SetNewPasswordState> {
  SetNewPasswordCubit(this._repository) : super(SetNewPasswordState.initial());
  final AuthRepository _repository;

  Future<void> resetPassword({
    required String token,
    required String password,
    required String confirmPassword,
  }) async {
    final params = SetNewPasswordParams(
        password: password,
        passwordConfirmation: confirmPassword,
        token: token);
    
    await callAndFold<Map<String, dynamic>>(
      future: _repository.setNewPassword(params: params),
      onDefaultEmit: (requestState) {
        emit(SetNewPasswordState(requestState: requestState));
      },
      error: (errorMessage) {
        String message = 'Please try again later';
        if (errorMessage.isNotEmpty) {
          message = errorMessage;
        }
        // TODO: Add proper error handling with UI helper
        print('Set new password error: $message');
      },
      success: (response) {
        // TODO: Add proper success handling with UI helper
        print('Set new password success');
      },
    );
  }
}
