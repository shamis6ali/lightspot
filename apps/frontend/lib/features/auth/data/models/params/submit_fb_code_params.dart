class SubmitFBCodeParams {
  final String phone, code;
  SubmitFBCodeParams(this.phone, this.code);

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'code': code,
    };
  }
}
