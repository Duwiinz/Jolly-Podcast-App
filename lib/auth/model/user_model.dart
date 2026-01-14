class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String country;
  final List<String> personalizations;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.country,
    required this.personalizations,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      country: json['country'],
      personalizations:
          List<String>.from(json['personalizations'] ?? []),
    );
  }
}
