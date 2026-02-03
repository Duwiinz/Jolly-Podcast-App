import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:jolly_podcast/auth/model/user_model.dart';
import 'package:jolly_podcast/auth/page/login.dart';
import 'package:jolly_podcast/auth/route/routes.dart';
import 'package:jolly_podcast/dashboard/main_screen.dart';
import 'package:jolly_podcast/dashboard/page/profile_page.dart';
import 'package:jolly_podcast/dashboard/route/routes.dart';
import 'package:jolly_podcast/splash_screen/splash_screen.dart';

class RouterClass {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    late Widget page;

    switch (settings.name) {
      case '/':
        page = const SplashScreen();
        break;

      case AuthRoutes.login:
        page = const LoginPage();
        break;

      case DashboardRoutes.mainScreen:
        page = const MainScreen();
        break;

      case DashboardRoutes.profilePage:
        final user = settings.arguments as UserModel;
        page = ProfilePage(user: user);
        break;

      default:
        page = Scaffold(
          body: Center(child: Text('No route defined for ${settings.name}')),
        );
    }

    // ✅ PREMIUM TRANSITION (FadeThrough)
    return PageRouteBuilder(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SharedAxisTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
          child: child,
        );
      },
    );
  }
}
