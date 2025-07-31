import 'dart:convert';

class User {
  final int id;
  final String? fullName;
  final String? email;
  final String phone;
  final double? lng;
  final double? lat;
  final bool isVerified;
  final String? accountType;
  final String? nationalId;
  final String? bankName;
  final String? iban;
  final String? image;
  final String? fullAddress;
  final String? livingType;
  final String? businessType;
  final String? verifiedAt;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.isVerified,
    required this.accountType,
    required this.nationalId,
    required this.bankName,
    required this.iban,
    required this.image,
    required this.fullAddress,
    required this.lng,
    required this.lat,
    required this.livingType,
    required this.businessType,
    required this.verifiedAt,
  });

  @override
  String toUserString() {
    Map<String, dynamic> userMap = {
      'id': id,
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'longitude': lng,
      'latitude': lat,
      'is_verified': isVerified,
      'account_type': accountType,
      'national_id': nationalId,
      'bank_name': bankName,
      'iban': iban,
      'image': image,
      'full_address': fullAddress,
      'living_type': livingType,
      'business_type': businessType,
      'phone_verified_at': verifiedAt,
    };
    return jsonEncode(userMap);
  }

  factory User.fromString(String userString) {
    Map<String, dynamic> userMap = jsonDecode(userString);
    return User(
      id: userMap['id'],
      fullName: userMap['full_name'],
      email: userMap['email'],
      phone: userMap['phone'],
      lng: userMap['longitude'] != null
          ? double.parse(userMap['longitude'].toString())
          : null,
      lat: userMap['latitude'] != null
          ? double.parse(userMap['latitude'].toString())
          : null,
      isVerified: userMap['is_verified'],
      accountType: userMap['account_type'],
      nationalId: userMap['national_id'],
      bankName: userMap['bank_name'],
      iban: userMap['iban'],
      image: userMap['image'],
      fullAddress: userMap['full_address'],
      livingType: userMap['living_type'],
      businessType: userMap['business_type'],
      verifiedAt: userMap['phone_verified_at'],
    );
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fullName: json["full_name"],
        email: json["email"],
        phone: json["phone"],
        isVerified: json["phone_verified_at"] != null,
        accountType: json["account_type"],
        nationalId: json["national_id"],
        bankName: json["bank_name"],
        iban: json["iban"],
        image: json["image"],
        fullAddress: json["full_address"],
        lng: json["longitude"] == null
            ? null
            : double.parse(json["longitude"].toString()),
        lat: json["latitude"] == null
            ? null
            : double.parse(json["latitude"].toString()),
        livingType: json["living_type"],
        businessType: json["business_type"],
        verifiedAt: json["phone_verified_at"],
      );
}
