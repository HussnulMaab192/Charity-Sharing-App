import 'package:charity_app/Screens/auth_screens/signin_screen.dart';
import 'package:charity_app/widgets/app_logo_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/get_user.dart';
import '../controllers/local_donation_controller.dart';
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
    Get.put(LocalDonationController());
    Get.find<LocalDonationController>().getTask();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Image.asset(
        "assets/logo/donateLogo.jpg",
        fit: BoxFit.cover,
      )),
    );
  }
}
