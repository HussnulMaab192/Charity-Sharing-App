import 'package:charity_app/Screens/auth_screens/signup_screen.dart';
import 'package:charity_app/Screens/forget_pswd.dart';
import 'package:charity_app/constaints.dart';
import 'package:charity_app/utils/validations/form_field_validation.dart';
import 'package:charity_app/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/get_user.dart';
import '../../controllers/password_controller.dart';
import '../../services/firebase_auth/firebase_auth.dart';
import '../../widgets/app_logo_text.dart';
import '../DonorScreens/add_donation.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String result = " my result";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _paswordControler = TextEditingController();

  final Firebaseauth _auth = Firebaseauth();
  String errorlabel = "";
  bool isLoading = false;
  signInUser() async {
    String res = await _auth.signIn(
        email: _emailController.text.trim(), password: _paswordControler.text);
    print(res);
    if (res == 'success') {
      setState(() {
        isLoading = true;
      });
      Get.snackbar("Message", "Successfully loged in.");
      // ignore: use_build_context_synchronously
      await Get.find<UserController>().getmyUser();
      Get.offAll(const AddDonation());
      _emailController.clear();
      _paswordControler.clear();
    } else {
      setState(() {
        isLoading = false;
        errorlabel = res.split("]")[1];
        result = res;
      });

      Get.snackbar("Message", res.trimLeft());
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(PasswordCntroller());
    final formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        // main column for body
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              // logo + app name
              AppLogoText(title: "Sign In "),
              SizedBox(
                height: 20.h,
              ),
              // Sign In Text

              // text Fields
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.h,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      // Enter email
                      myTextField(
                          hintText: "Enter Email",
                          preIcon: Icons.email,
                          mycontroller: _emailController),

                      SizedBox(height: 10.h),

                      GetBuilder<PasswordCntroller>(
                        builder: (pswdController) => myTextField(
                          validator: passwordValidator,
                          isObsecure: pswdController.isSignInObscure,
                          hintText: "Enter Password",
                          preIcon: Icons.lock,
                          mycontroller: _paswordControler,
                          suffixIcon: pswdController.isSignInObscure
                              ? Icons.visibility
                              : Icons.visibility_off,
                          onTap: pswdController.updateSignInPasswordObscure,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(ForgetPassword());
                          },
                          child: const Text(
                            "Forgot Password",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),

                      // choose location
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20.h),
              Text(
                errorlabel,
                style: const TextStyle(
                    fontSize: 16,
                    fontFamily: "Rubik Medium",
                    color: Colors.red),
              ),
              // Sign Up button
              isLoading
                  ? const Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.0.w,
                      ),
                      child: InkWell(
                        onTap: () async {
                          if ((formKey.currentState!.validate())) {
                            await signInUser();
                          } else {
                            return;
                          }
                        },
                        child: Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              color: Get.isDarkMode
                                  ? Colors.teal
                                  : primaryLightClr,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.0.r),
                              child: Text("Sign In"),
                            ),
                          ),
                        ),
                      ),
                    ),

              SizedBox(
                height: 10.h,
              ),
              // Already have an account text ?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an Account ?",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Rubik Regular',
                        color: Get.isDarkMode ? Colors.white : Colors.black),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()));
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                          fontFamily: 'Rubik Medium',
                          color:
                              Get.isDarkMode ? Colors.teal : primaryLightClr),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
