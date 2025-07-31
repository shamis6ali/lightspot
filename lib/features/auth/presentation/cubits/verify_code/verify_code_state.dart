part of 'verify_code_cubit.dart';

@immutable
class VerifyCodeState extends Equatable {
  final RequestState<VerifyResponse> requestState;

  const VerifyCodeState({required this.requestState});

  factory VerifyCodeState.initial() {
    return VerifyCodeState(requestState: RequestState.initial());
  }

  @override
  List<Object?> get props => [requestState];
}
