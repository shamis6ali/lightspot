class SetNewPasswordParams {
  final String password, passwordConfirmation, token;

  SetNewPasswordParams(
      {required this.password,
      required this.passwordConfirmation,
      required this.token});

  Map<String, dynamic> toJson() {
    return {
      'password': password,
      'password_confirmation': passwordConfirmation,
    };
  }
}
