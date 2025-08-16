class RegisterParams {
  final String phone,
      password,
      // fullName,
      // email,
      // accountType,
      passwordConfirmation;
  RegisterParams(
      // this.fullName,
      // this.accountType,
      // this.email,
      this.passwordConfirmation,
      {required this.phone,
      required this.password});

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'password': password,
      // 'full_name': fullName,
      // 'email': email,
      // 'account_type': accountType,
      'password_confirmation': passwordConfirmation,
    };
  }
}
