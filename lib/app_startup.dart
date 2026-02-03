import 'package:get_it/get_it.dart';
import 'package:jolly_podcast/dashboard/home_screen/cubit/episode_cubit.dart';
import 'package:jolly_podcast/dashboard/services/episode_service.dart';
import 'package:jolly_podcast/storage/app_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../http/http_service.dart';
import '../../auth/services/auth_service.dart';
import '../../auth/cubit/auth_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // 🔹 SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  // 🔹 AppPreferences
  getIt.registerLazySingleton<AppPreferences>(
    () => AppPreferences(getIt<SharedPreferences>()),
  );

  // 🔹 HTTP Client
  getIt.registerLazySingleton<HttpClientService>(
    () => HttpClientService(getIt<AppPreferences>()),
  );

  // 🔹 Auth Service
  getIt.registerLazySingleton<AuthService>(
    () => AuthService(getIt<HttpClientService>()),
  );

  // 🔹 Episode Service
  getIt.registerLazySingleton<EpisodeService>(
    () => EpisodeService(getIt<HttpClientService>()),
  );

  // ✅ Cubits MUST be factories
getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<AuthService>()));

  getIt.registerFactory<EpisodeCubit>(
    () => EpisodeCubit(getIt<EpisodeService>()),
  );
}
