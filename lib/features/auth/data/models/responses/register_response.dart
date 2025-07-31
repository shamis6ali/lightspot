class RegisterResponse {
  final int code;
  final String? message;

  RegisterResponse({
    required this.code,
    this.message,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
        code: json["code"],
        message: json["message"],
      );
}
