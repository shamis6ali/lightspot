class LoginParams {
  final String email, password;
  String fcmToken = '';
  LoginParams({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'fcm_token': fcmToken,
    };
  }
}
