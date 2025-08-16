part of 'delete_account_cubit.dart';

@immutable
class DeleteAccountState extends Equatable {
  final RequestState<Map<String, dynamic>> requestState;

  const DeleteAccountState({required this.requestState});

  factory DeleteAccountState.initial() {
    return DeleteAccountState(requestState: RequestState.initial());
  }

  @override
  List<Object?> get props => [requestState];
}
