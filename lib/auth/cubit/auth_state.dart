import 'package:jolly_podcast/auth/model/user_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

// class OtpSent extends AuthState {
//   final String phone;
//   OtpSent(this.phone);
// }

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthAuthenticated extends AuthState {
  final UserModel user;

  AuthAuthenticated(this.user);
}

class AuthLoggingOut extends AuthState {}

class AuthLoggedOut extends AuthState {}

