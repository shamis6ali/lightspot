import '../user.dart';

class LoginResponse {
  final int code;
  final String? message;
  final String? token;
  final User user;
  final DateTime? expiresAt;

  LoginResponse({
    required this.code,
    this.message,
    required this.user,
    this.token,
    this.expiresAt,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        code: json["code"],
        message: json["message"],
        token: json["body"]["token"],
        user: User.fromJson(json["body"]["user"]),
        expiresAt: json["body"]["expires_at"] == null
            ? null
            : DateTime.parse(json["body"]["expires_at"]),
      );
}
