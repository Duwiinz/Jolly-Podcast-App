import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jolly_podcast/app_startup.dart';
import 'package:jolly_podcast/utils_folder/app_colors.dart';
import 'package:jolly_podcast/utils_folder/navigation_key.dart';
import 'package:jolly_podcast/utils_folder/routes.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // load registered cubits
  await setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // designSize: const Size(540, 960),
      designSize: const Size(
        375,
        812,
      ), // The size of the device screen in the design draft (e.g Figma), in dp
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, widget) {
        return MaterialApp(
          // start of -----> for device preview
          // useInheritedMediaQuery: true, // Important!
          // locale: DevicePreview.locale(context),
          // builder: DevicePreview.appBuilder,
          // end of -----> for device preview

          // to hide keyboard when you tap anywhere across the app: For Entire App: Wrap in MaterialApp's builder
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

  // GLOBAL TextField / TextFormField styling (including your CustomTextFormField)
  inputDecorationTheme: InputDecorationTheme(
    // error text color
    errorStyle: const TextStyle(
      color: Colors.red,
      fontSize: 12,
      fontWeight: FontWeight.w800,
    ),

    // normal borders
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(27),
      borderSide: BorderSide(color: Colors.white.withOpacity(0.25)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(27),
      borderSide: BorderSide(color: AppColors.color33, width: 1.8),
    ),

    //  error borders
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
          // home: const MyHomePage(),
          initialRoute: "/",
          onGenerateRoute: RouterClass.generateRoute,
        );
      },
    );
  }
}

