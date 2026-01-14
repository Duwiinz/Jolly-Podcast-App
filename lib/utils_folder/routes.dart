import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolly_podcast/app_startup.dart';
import 'package:jolly_podcast/auth/page/login.dart';
// import 'package:jolly_podcast/auth/page/request_otp.dart';
import 'package:jolly_podcast/auth/route/routes.dart';
import 'package:jolly_podcast/dashboard/home_screen/cubit/episode_cubit.dart';
import 'package:jolly_podcast/dashboard/main_screen.dart';
import 'package:jolly_podcast/dashboard/route/routes.dart';
import 'package:jolly_podcast/splash_screen/splash_screen.dart';

class RouterClass {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      // return MaterialPageRoute(builder: (_) => const FundWallet());

      // Auth and onboarding
      // case AuthRoutes.requestOtpPage:
      //   return MaterialPageRoute(builder: (_) => const RequestOtpPage());

      case AuthRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());

      // Dashboard / Main Screen
      case DashboardRoutes.mainScreen:
  return MaterialPageRoute(
    builder: (_) => BlocProvider(
      create: (_) => getIt<EpisodeCubit>()..fetchEpisodes(),
      child: const MainScreen(),
    ),
  );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
