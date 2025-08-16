import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../../common/dart/base_cubit.dart';
import '../../../../../common/dart/request_state.dart';
import '../../../data/repository/auth_repo.dart';

part 'delete_account_state.dart';

@injectable
class DeleteAccountCubit extends BaseCubit<DeleteAccountState> {
  DeleteAccountCubit(this._repository) : super(DeleteAccountState.initial());
  final AuthRepository _repository;

  Future<void> deleteAccount() async {
    await callAndFold<Map<String, dynamic>>(
      future: _repository.deleteAccount(),
      onDefaultEmit: (requestState) {
        emit(DeleteAccountState(requestState: requestState));
      },
      error: (errorMessage) {
        String message = 'Please try again later';
        if (errorMessage.isNotEmpty) {
          message = errorMessage;
        }
        // TODO: Add proper error handling with UI helper
        print('Delete account error: $message');
      },
      success: (response) {
        // TODO: Add proper success handling with UI helper
        print('Delete account success');
      },
    );
  }
}
