import 'package:charity/Screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // only for android // do some changings for web and ios
  await Firebase.initializeApp();
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
          theme: theme(),
          home: const SplashScreen(),
        );
      },
    );
  }

// THEME - OF - THE - APPLICATOIN
  ThemeData theme() {
    return ThemeData(
      primaryColor: Colors.white,
      backgroundColor: Colors.white,
      primarySwatch: Colors.orange,
      // see
    );
  }
}
