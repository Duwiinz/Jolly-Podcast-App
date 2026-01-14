import 'package:jwt_decoder/jwt_decoder.dart';

class JwtUtils {
  /// Returns true if token is expired
  static bool isTokenExpired(String token) {
    return JwtDecoder.isExpired(token);
  }

  /// Optional: decode token
  static Map<String, dynamic> decodeToken(String token) {
    return JwtDecoder.decode(token);
  }
}
