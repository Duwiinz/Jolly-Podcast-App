//import 'dart:io';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/auth_service.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService authService;

  AuthCubit(this.authService) : super(AuthInitial());

  // Future<void> requestOtp({required String phone}) async {
  //   emit(AuthLoading());

  //   try {
  //     await authService.requestOtp(phone);
  //     emit(OtpSent(phone));
  //   } catch (e) {
  //     emit(AuthError(e.toString()));
  //   }
  // }

  Future<void> login({
    required String phone,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      final result = await authService.login(
        phone: phone,
        password: password,
      );

      await authService.client.prefs.saveToken(result.token);

      emit(AuthAuthenticated(result.user));
    } catch (e) {
      log('[AuthCubit] error: $e');
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
  emit(AuthLoggingOut());

  try {
    await authService.logout();
  } catch (e) {
    // Even if server says 401, we still log user out locally
    log('[AuthCubit] logout error (ignored): $e');
  } finally {
    await authService.client.prefs.clearSession();
    // If you store user locally, clear it too:
    // await authService.client.prefs.clearUser();

    emit(AuthLoggedOut());
  }
}
}
