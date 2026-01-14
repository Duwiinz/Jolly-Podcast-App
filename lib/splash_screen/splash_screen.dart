import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jolly_podcast/auth/route/routes.dart';
import 'package:jolly_podcast/utils_folder/navigation_key.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  redirectAfterSplashScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      log('3 second has passed.'); // Prints after 3 second.

      navigatorKey.currentState!.pushNamedAndRemoveUntil(
        AuthRoutes.login,
        (Route<dynamic> route) => false,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    // whenever your initialization is completed, remove the splash screen:
    FlutterNativeSplash.remove();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      redirectAfterSplashScreen();
    });
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      fit: StackFit.expand,
      children: [
        // 🔹 Background image (from Figma)
        Image.asset(
          "assets/images/splashScreenBackground.png",
          fit: BoxFit.cover,
        ),

        // 🔹 Logo on top of background
        Positioned(
          top: 235.h, 
          left: 0,
          right: 0,
          child: Center(
            child: Image.asset(
              "assets/images/splashScreenLogo.png",
              width: 213.w,
              height: 87.h,
            ),
          ),
        ),
      ],
    ),
  );
}

}