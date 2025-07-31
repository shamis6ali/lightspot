import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../../common/dart/base_cubit.dart';
import '../../../../../common/dart/request_state.dart';
import 'package:lightspot_v1/features/auth/data/models/params/register_params.dart';
import 'package:lightspot_v1/features/auth/data/models/responses/register_response.dart';
import 'package:lightspot_v1/features/auth/data/repository/auth_repo.dart';

part 'signup_state.dart';

@injectable
class SignupCubit extends BaseCubit<SignupState> {
  final AuthRepository _repository;
  SignupCubit(this._repository) : super(SignupState.initial());

  final List<String> _banks = [];
  List<DropdownMenuItem<String>> get banks => _banks
      .map(
        (bank) => DropdownMenuItem<String>(
            value: bank,
            child: Text(
              bank,
              style: TextStyle(fontSize: 14),
            )),
      )
      .toList();

  Future<void> signup({required RegisterParams params}) async {
    await callAndFold<RegisterResponse>(
      future: _repository.register(params: params),
      onDefaultEmit: (requestState) {
        emit(SignupState(requestState: requestState));
      },
      error: (errorMessage) {
        String message = 'Please try again later';
        if (errorMessage.isNotEmpty) {
          message = errorMessage;
        }
        // TODO: Add proper error handling with UI helper
        print('Signup error: $message');
      },
      success: (response) {
        // TODO: Add proper success handling with UI helper
        print('Signup success');
      },
    );
  }
}
