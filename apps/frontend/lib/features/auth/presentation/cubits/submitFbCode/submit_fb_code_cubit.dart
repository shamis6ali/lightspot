import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../../common/dart/base_cubit.dart';
import '../../../../../common/dart/request_state.dart';
import '../../../data/models/params/submit_fb_code_params.dart';
import '../../../data/repository/auth_repo.dart';
import '../../../data/models/responses/verify_fb_response.dart';

part 'submit_fb_code_state.dart';

@injectable
class SubmitFbCodeCubit extends BaseCubit<SubmitFbCodeState> {
  SubmitFbCodeCubit(this._repository) : super(SubmitFbCodeState.initial());
  final AuthRepository _repository;

  Future<String?> verifyCode({
    required String code,
    required String phone,
  }) async {
    final params = SubmitFBCodeParams(phone, code);
    
    String? token;
    await callAndFold<VerifyFBResponse>(
      future: _repository.submitForgetPasswordCode(params: params),
      onDefaultEmit: (requestState) {
        emit(SubmitFbCodeState(requestState: requestState));
      },
      error: (errorMessage) {
        String message = 'Please try again later';
        if (errorMessage.isNotEmpty) {
          message = errorMessage;
        }
        // TODO: Add proper error handling with UI helper
        print('Submit FB code error: $message');
        token = null;
      },
      success: (response) {
        // TODO: Add proper success handling with UI helper
        print('Submit FB code success');
        token = response.token;
      },
    );
    return token;
  }
}
