import 'package:charity_app/Screens/splash_screen.dart';
import 'package:charity_app/firebase_options.dart';
import 'package:charity_app/services/Databases/my_sqflite.dart';
import 'package:charity_app/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // only for android // do some changings for web and ios
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await DBHelper.initDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return getScreenUtils();
  }

// SCREENUTILL - OF - THE - APPLICATOIN
  ScreenUtilInit getScreenUtils() {
    return ScreenUtilInit(
      designSize: const Size(360, 790),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          darkTheme: Themes.dark,
          theme: Themes.light,
          home: const SplashScreen(),
        );
      },
    );
  }
}
