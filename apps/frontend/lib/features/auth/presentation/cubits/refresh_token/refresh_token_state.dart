part of 'refresh_token_cubit.dart';

@immutable
class RefreshTokenState extends Equatable {
  final RequestState<LoginResponse> requestState;

  const RefreshTokenState({required this.requestState});

  factory RefreshTokenState.initial() {
    return RefreshTokenState(requestState: RequestState.initial());
  }

  @override
  List<Object?> get props => [requestState];
}
