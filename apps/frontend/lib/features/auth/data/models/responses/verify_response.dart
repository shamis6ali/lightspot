class VerifyResponse {
  final int code;
  final String? message;
  final String token;

  VerifyResponse({
    required this.code,
    this.message,
    required this.token,
  });

  factory VerifyResponse.fromJson(Map<String, dynamic> json) => VerifyResponse(
        code: json["code"],
        message: json["message"],
        token: json["body"]["token"],
      );
}
