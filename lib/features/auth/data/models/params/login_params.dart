class LoginParams {
  final String phone, password;
  String fcmToken = '';
  LoginParams({required this.phone, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'password': password,
      'fcm_token': fcmToken,
    };
  }
}
