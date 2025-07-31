part of 'login_cubit.dart';

@immutable
class LoginState extends Equatable {
  final RequestState<LoginResponse> requestState;

  const LoginState({required this.requestState});

  factory LoginState.initial() {
    return LoginState(requestState: RequestState.initial());
  }

  @override
  List<Object?> get props => [requestState];
}
