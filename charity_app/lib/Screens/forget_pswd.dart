import 'package:charity_app/Screens/auth_screens/signin_screen.dart';
import 'package:charity_app/services/firebase_auth/firebase_auth.dart';
import 'package:charity_app/widgets/app_logo_text.dart';
import 'package:charity_app/widgets/default_button.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

Widget myTextField(
    String hintText, Icon preIcon, TextEditingController mycontroller) {
  return TextFormField(
    controller: mycontroller,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
          fontSize: 16, fontFamily: "Rubik Medium", color: Colors.black),
      fillColor: Colors.orange,
      prefixIcon: preIcon,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.orange,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(35),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.orange,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    validator: ((value) {
      if (value!.isEmpty) {
        if (hintText == "Enter Email") {
          return "Enter Email Please";
        }
      }
      return null;
    }),
  );
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  final TextEditingController _emailController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 54.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppLogoText(title: "Forgot Password"),
            myTextField(
                "Enter your Email", const Icon(Icons.email), _emailController),
            SizedBox(height: 8.h),
            SizedBox(
              width: double.maxFinite,
              child: DefaultButton(
                fontSize: 18.sp,
                text: "Send",
                onPressed: () async {
                  await Firebaseauth()
                      .forgetPassword(email: _emailController.text);
                  Get.offAll(const SignIn());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
