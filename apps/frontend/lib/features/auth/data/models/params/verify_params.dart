class VerifyParams {
  final String phone, password, code;
  VerifyParams(
      {required this.code, required this.phone, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'password': password,
      'code': code,
    };
  }
}
