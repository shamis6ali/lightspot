class VerifyFBResponse {
  final int code;
  final String? message;
  final String token;

  VerifyFBResponse({
    required this.code,
    this.message,
    required this.token,
  });

  factory VerifyFBResponse.fromJson(Map<String, dynamic> json) =>
      VerifyFBResponse(
        code: json["code"],
        message: json["message"],
        token: json["body"]["forget_password_token"],
      );
}
