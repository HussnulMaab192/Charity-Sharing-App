import 'package:charity_app/Screens/auth_screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/get_user.dart';
import 'DonorScreens/Add Donations/add_donation.dart';

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
    await Future.delayed(const Duration(seconds: 1));
    if (FirebaseAuth.instance.currentUser != null) {
      await Get.find<UserController>().getmyUser();
      Get.off(const AddDonation());
    } else {
      Get.off(const SignIn());
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    return const Scaffold(
      body: Center(child: const FlutterLogo()),
    );
  }
}
