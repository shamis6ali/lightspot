part of 'signup_cubit.dart';

@immutable
class SignupState extends Equatable {
  final RequestState<RegisterResponse> requestState;

  const SignupState({required this.requestState});

  factory SignupState.initial() {
    return SignupState(requestState: RequestState.initial());
  }

  @override
  List<Object?> get props => [requestState];
}
