part of 'send_fb_code_cubit.dart';

@immutable
class SendFbCodeState extends Equatable {
  final RequestState<Map<String, dynamic>> requestState;

  const SendFbCodeState({required this.requestState});

  factory SendFbCodeState.initial() {
    return SendFbCodeState(requestState: RequestState.initial());
  }

  @override
  List<Object?> get props => [requestState];
}
