import 'package:charity_app/Screens/DonorScreens/add_donation.dart';
import 'package:charity_app/Screens/auth_screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/get_user.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    chkLogin();
    super.initState();
  }

  Future<void> chkLogin() async {
    await Future.delayed(Duration(seconds: 1));
    if (FirebaseAuth.instance.currentUser != null) {
      await Get.find<UserController>().getmyUser();
      Get.off(AddDonation());
    } else {
      Get.off(SignIn());
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    return Scaffold(
      body: Center(child: FlutterLogo()),
    );
  }
}
