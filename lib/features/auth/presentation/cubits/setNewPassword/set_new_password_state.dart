part of 'set_new_password_cubit.dart';

@immutable
class SetNewPasswordState extends Equatable {
  final RequestState<Map<String, dynamic>> requestState;

  const SetNewPasswordState({required this.requestState});

  factory SetNewPasswordState.initial() {
    return SetNewPasswordState(requestState: RequestState.initial());
  }

  @override
  List<Object?> get props => [requestState];
}
