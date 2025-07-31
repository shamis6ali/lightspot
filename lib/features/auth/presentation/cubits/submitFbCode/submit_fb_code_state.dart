part of 'submit_fb_code_cubit.dart';

@immutable
class SubmitFbCodeState extends Equatable {
  final RequestState<VerifyFBResponse> requestState;

  const SubmitFbCodeState({required this.requestState});

  factory SubmitFbCodeState.initial() {
    return SubmitFbCodeState(requestState: RequestState.initial());
  }

  @override
  List<Object?> get props => [requestState];
}
