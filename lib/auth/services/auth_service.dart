import 'dart:convert';
import 'dart:developer';
// import 'package:http/http.dart';
import 'package:jolly_podcast/auth/model/login_response_model.dart';
import 'package:jolly_podcast/http/http_service.dart';
import 'package:jolly_podcast/network/api_routes.dart';

class AuthService {
  final HttpClientService client;

  AuthService(this.client);

  /// Request OTP (Onboarding)
  // Future<void> requestOtp(String phone) async {
  //   log("AuthService: requestOtp called with phone: $phone", name: "AuthService");
    
  //   final Response response = await client.post(
  //     ApiRoutes.requestOtp,
  //     body: {
  //       'phone': phone,
  //     },
  //   );

  //   log("AuthService: Response received", name: "AuthService");
  //     log("Status code: ${response.statusCode}", name: "AuthService");
  //     log("Body: ${response.body}", name: "AuthService");

  //   final decoded = jsonDecode(response.body);

  //   if (response.statusCode == 200) {
  //     return;
  //   } else if (response.statusCode == 400) {
  //     throw Exception('Invalid phone number');
  //   } else if (response.statusCode == 503) {
  //     throw Exception('Failed to send SMS');
  //   } else {
  //     throw Exception(
  //       decoded['message'] ?? 'Something went wrong',
  //     ); 
  //   }
  // }

  //  /// Verify OTP
  // Future<void> verifyOtp({required String phone, required String otp}) async {
  //   final response = await client.post(
  //     ApiRoutes.verifyOtp,
  //     body: {
  //       'phone_number': phone,
  //       'otp': otp,
  //     },
  //   );

  //   final decoded = jsonDecode(response.body);

  //   if (response.statusCode == 200) {
  //     return; // OTP verified successfully
  //   } else if (response.statusCode == 400) {
  //     throw Exception('Invalid OTP');
  //   } else if (response.statusCode == 404) {
  //     throw Exception('Phone number not found');
  //   } else {
  //     throw Exception(decoded['message'] ?? 'Something went wrong');
  //   }
  // }

  /// Login

  Future<LoginResponseModel> login({
    required String phone,
    required String password,
  }) async {
    log('[AuthService] login called');

    final response = await client.post(
      ApiRoutes.login,
      body: {
        'phone_number': phone,
        'password': password,
      },
    );

    final decoded = jsonDecode(response.body);
    return LoginResponseModel.fromJson(decoded);
  }

}
