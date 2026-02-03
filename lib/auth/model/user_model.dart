class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String jollyEmail; // ✅
  final String country;
  final List<String> personalizations;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.jollyEmail,
    required this.country,
    required this.personalizations,
  });

  static int _asInt(dynamic v) {
    if (v == null) return 0;
    if (v is int) return v;
    if (v is num) return v.toInt();
    return int.tryParse(v.toString()) ?? 0;
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: _asInt(json['id']),
      firstName: (json['first_name'] ?? '').toString(),
      lastName: (json['last_name'] ?? '').toString(),
      phoneNumber: (json['phone_number'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      jollyEmail: (json['jolly_email'] ?? '').toString(),
      country: (json['country'] ?? '').toString(),
      personalizations: List<String>.from(json['personalizations'] ?? []),
    );
  }

  String get fullName => ('$firstName $lastName').trim();
}
