import 'package:charity_app/Screens/auth_screens/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/password_controller.dart';
import '../../services/firebase_auth/firebase_auth.dart';
import '../../widgets/app_logo_text.dart';

import '../DonorScreens/add_donation.dart';
import '../forget_pswd.dart';

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
      Get.off(const AddDonation());
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
                      myTextField("Enter Email", const Icon(Icons.email),
                          _emailController),

                      SizedBox(height: 10.h),

                      GetBuilder<PasswordCntroller>(
                        builder: (pswdController) => TextFormField(
                          controller: _paswordControler,
                          obscureText: pswdController.isSignInObscure,
                          decoration: InputDecoration(
                            hintText: "Enter Password",
                            hintStyle: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Rubik Medium',
                                color: Colors.black),
                            fillColor: Colors.orange,
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.orange,
                            ),
                            // const Icon(Icons.visibility,color: Colors.orange,),
                            suffixIcon: IconButton(
                              icon: const Icon(
                                Icons.visibility,
                                color: Colors.orange,
                              ),
                              onPressed: () {
                                pswdController.updateSignInPasswordObscure();
                              },
                            ),
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Password First";
                            }
                            return null;
                          },
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
                  : InkWell(
                      onTap: () {
                        if ((formKey.currentState!.validate())) {
                          signInUser();
                        } else {
                          return;
                        }
                      },
                      child: Container(
                        height: 30.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Center(
                          child: Text("Sign In"),
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
                  const Text(
                    "Don't have an Account ?",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Rubik Regular',
                        color: Colors.black),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()));
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                          fontFamily: 'Rubik Medium',
                          color: Colors.orange),
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
