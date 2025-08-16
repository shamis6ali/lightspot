import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../../common/dart/base_cubit.dart';
import '../../../../../common/dart/request_state.dart';
import '../../../data/models/params/verify_params.dart';
import '../../../data/models/responses/verify_response.dart';
import '../../../data/repository/auth_repo.dart';

part 'verify_code_state.dart';

@injectable
class VerifyCodeCubit extends BaseCubit<VerifyCodeState> {
  VerifyCodeCubit(this._repository) : super(VerifyCodeState.initial());
  final AuthRepository _repository;

  Future<bool> verifyCode({
    required String code,
    required String phone,
    required String password,
  }) async {
    final params = VerifyParams(code: code, phone: phone, password: password);
    
    bool success = false;
    await callAndFold<VerifyResponse>(
      future: _repository.verifyCode(params: params),
      onDefaultEmit: (requestState) {
        emit(VerifyCodeState(requestState: requestState));
      },
      error: (errorMessage) {
        String message = 'Please try again later';
        if (errorMessage.isNotEmpty) {
          message = errorMessage;
        }
        // TODO: Add proper error handling with UI helper
        print('Verify code error: $message');
        success = false;
      },
      success: (response) {
        // TODO: Add proper success handling with UI helper
        print('Verify code success');
        success = true;
      },
    );
    return success;
  }
}
