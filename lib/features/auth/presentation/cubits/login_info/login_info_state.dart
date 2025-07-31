part of 'login_info_cubit.dart';

@immutable
class LoginInfoState extends Equatable {
  final bool isLoading;
  final bool isLoaded;

  const LoginInfoState({
    this.isLoading = false,
    this.isLoaded = false,
  });

  factory LoginInfoState.initial() {
    return const LoginInfoState();
  }

  factory LoginInfoState.loading() {
    return const LoginInfoState(isLoading: true);
  }

  factory LoginInfoState.loaded() {
    return const LoginInfoState(isLoaded: true);
  }

  @override
  List<Object?> get props => [isLoading, isLoaded];
}
