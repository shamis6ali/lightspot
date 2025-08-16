import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../../common/dart/base_cubit.dart';
import '../../../../../common/dart/request_state.dart';
import '../../pages/verifty_code_screen.dart';
import '../../../data/models/params/send_fb_code_params.dart';
import '../../../data/repository/auth_repo.dart';
import '../submitFbCode/submit_fb_code_cubit.dart';

part 'send_fb_code_state.dart';

@injectable
class SendFbCodeCubit extends BaseCubit<SendFbCodeState> {
  SendFbCodeCubit(this._repository) : super(SendFbCodeState.initial());
  final AuthRepository _repository;

  Future<void> sendCode(
      {required String phone,
      required Null Function(String token) onSuccess,
      required BuildContext context}) async {
    final params = SendFBCodeParams(phone);
    
    await callAndFold<Map<String, dynamic>>(
      future: _repository.sendFBCode(params: params),
      onDefaultEmit: (requestState) {
        emit(SendFbCodeState(requestState: requestState));
      },
      error: (errorMessage) {
        String message = 'Please try again later';
        if (errorMessage.isNotEmpty) {
          message = errorMessage;
        }
        // TODO: Add proper error handling with UI helper
        print('Send FB code error: $message');
      },
      success: (response) {
        // TODO: Add proper success handling with UI helper
        print('Send FB code success');
        showVerificationBottomSheet(context, phone: phone, onSuccess: onSuccess);
      },
    );
  }

  void showVerificationBottomSheet(BuildContext context,
      {required String phone, Function(String token)? onSuccess}) async {
    await showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        elevation: 20,
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          return VerifyScreen(
            onSendClicked: (String code) async {
              // TODO: Fix sl import issue
              // final token = await sl<SubmitFbCodeCubit>()
              //     .verifyCode(code: code, phone: phone);
              // final bool isSuccess = token != null;
              // if (isSuccess) {
              //   if (onSuccess != null) {
              //     onSuccess(token);
              //   } else {}
              // }
            },
            onReSendClicked: () {
              // sl<ResendVerifyCubit>().fResendVerifyCode(token: token);
            },
            phone: phone,
          );
        });
  }
}
