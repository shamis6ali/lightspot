class SendFBCodeParams {
  final String phone;
  SendFBCodeParams(this.phone);

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
    };
  }
}
