import 'package:jolly_podcast/auth/model/user_model.dart';

class LoginResponseModel {
  final UserModel user;
  final String token;

  LoginResponseModel({
    required this.user,
    required this.token,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      user: UserModel.fromJson(json['data']['user']),
      token: json['data']['token'],
    );
  }
}
