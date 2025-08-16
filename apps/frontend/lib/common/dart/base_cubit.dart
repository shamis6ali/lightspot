import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'failure.dart';
import 'request_state.dart';


class BaseCubit<State> extends Cubit<State> {
  BaseCubit(super.initialState);

  @override
  void emit(State state) {
    if (isClosed) return;
    super.emit(state);
  }

  Future<void> callAndFold<T>({
    required Future<Either<Failure, T>> future,
    required Function(RequestState<T> requestState) onDefaultEmit,
    Function(String errorMessage)? error,
    Function(T data)? success,
  }) async {
    final loadingState = RequestState<T>.loading();
    onDefaultEmit(loadingState);
    final result = await future;
    result.fold(
      (Failure failure) {
        if (error != null) {
          error(failure.message);
        } else {
          final errorState = RequestState<T>.error(failure.message);
          onDefaultEmit(errorState);
        }
      },
      (data) {
        if (success != null) {
          success(data);
        } else {
        final successState = RequestState<T>.success(data);
          onDefaultEmit(successState);
        }
      },
    );
  }


}