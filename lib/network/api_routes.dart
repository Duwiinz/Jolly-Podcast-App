class ApiRoutes {
  static const String baseUrl = 'https://api.jollypodcast.net';

  // // Onboarding OTP request
  // static const String requestOtp = '$baseUrl/api/auth/otp';

  // // OTP verification
  // static const String verifyOtp = '$baseUrl/api/auth/verify-otp';

  // Login endpoint
  static const String login = '$baseUrl/api/auth/login';

  // // Podcast endpoint
  // static const String getPodcasts = '$baseUrl/api/podcasts';

   // 🎧 Episodes
  static const String trendingEpisodes = '$baseUrl/api/episodes/trending';

  static const String editorsPickEpisodes = '$baseUrl/api/episodes/editor-pick';

  static const String logout = '$baseUrl/api/auth/logout';
}

