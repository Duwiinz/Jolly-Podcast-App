import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jolly_podcast/app_startup.dart';
import 'package:jolly_podcast/auth/cubit/auth_cubit.dart';
import 'package:jolly_podcast/utils_folder/app_colors.dart';
import 'package:jolly_podcast/utils_folder/navigation_key.dart';
import 'package:jolly_podcast/utils_folder/routes.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await setupDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, widget) {
        return MultiBlocProvider(
          providers: [
            // ✅ ONE global AuthCubit for the entire app
            BlocProvider<AuthCubit>(create: (_) => getIt<AuthCubit>()),
          ],
          child: MaterialApp(
            builder: (context, child) {
              return GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                behavior: HitTestBehavior.translucent,
                child: child!,
              );
            },
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            title: 'Jolly Podcast',
            theme: ThemeData(
              useMaterial3: true,
              textTheme: GoogleFonts.nunitoTextTheme(),
              iconTheme: IconThemeData(color: AppColors.color1),
              inputDecorationTheme: InputDecorationTheme(
                errorStyle: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(27),
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.25)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(27),
                  borderSide: BorderSide(color: AppColors.color33, width: 1.8),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(27),
                  borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(27),
                  borderSide: const BorderSide(color: Colors.redAccent, width: 1.8),
                ),
              ),
            ),
            initialRoute: "/",
            onGenerateRoute: RouterClass.generateRoute,
          ),
        );
      },
    );
  }
}
