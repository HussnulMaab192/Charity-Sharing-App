import 'package:charity_app/Screens/auth_screens/signin_screen.dart';
import 'package:charity_app/controllers/password_controller.dart';
import 'package:charity_app/services/firebase_auth/firebase_auth.dart';
import 'package:charity_app/utils/validations/form_field_validation.dart';
import 'package:charity_app/widgets/app_logo_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constaints.dart';
import '../../widgets/custom_text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // creating teh firebase class  auth instance

  final formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  final Firebaseauth _auth = Firebaseauth();
  String errorlabel = "";
  // create the bool here
  bool isLoading = false; // this is for loader
// create the funcitoin here
  registerUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await _auth.createUser(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      name: _nameController.text.trim(),
      phoneNumber: _mobileNumberController.text.trim(),
      location: _locationController.text,
    );
    if (res == 'success') {
      setState(() {
        isLoading = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please verify Your Email")));
      Get.off(const SignIn());
    } else {
      setState(() {
        isLoading = false;
        errorlabel = res.split("]")[1];
      });
      Get.snackbar("Message", res);
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(PasswordCntroller());
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          //
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              AppLogoText(title: "Sign Up"),

              // text Fields
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),

                      // Enter name field,
                      myTextField(
                          hintText: "Enter Your Name",
                          preIcon: Icons.person,
                          mycontroller: _nameController,
                          validator: requiredValidator),

                      SizedBox(height: 10.h),

                      // Enter mobile no
                      myTextField(
                        hintText: "Enter Mobile number",
                        preIcon: Icons.phone_android,
                        mycontroller: _mobileNumberController,
                        validator: requiredValidator,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 10.h),

                      // Enter email
                      myTextField(
                        hintText: "Enter Email",
                        preIcon: Icons.email,
                        mycontroller: _emailController,
                        validator: requiredValidator,
                      ),
                      SizedBox(height: 10.h),

                      GetBuilder<PasswordCntroller>(
                        builder: (pswdController) => myTextField(
                          validator: passwordValidator,
                          isObsecure: pswdController.isSignUpObscure,
                          hintText: "Enter Password",
                          preIcon: Icons.lock,
                          mycontroller: _passwordController,
                          suffixIcon: pswdController.isSignUpObscure
                              ? Icons.visibility
                              : Icons.visibility_off,
                          onTap: pswdController.updateSignUpPasswordObscure,
                        ),
                      ),

                      SizedBox(height: 10.h),

                      // choose location
                      myTextField(
                        hintText: "Choose location",
                        preIcon: Icons.location_city_sharp,
                        mycontroller: _locationController,
                        validator: requiredValidator,
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                errorlabel,
                style: const TextStyle(
                    fontSize: 16,
                    fontFamily: "Rubik Medium",
                    color: Colors.red),
              ),
              SizedBox(height: 20.h),
              // Sign Up button
              isLoading
                  ? const Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.r),
                      child: InkWell(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            registerUser();
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
                              child: const Text("SignUp"),
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
                    "Already have an Account ?",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Rubik Regular',
                        color: Get.isDarkMode ? Colors.white : Colors.black),
                  ),
                  SizedBox(
                    width: 10.h,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignIn()));
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                          fontFamily: 'Rubik Medium',
                          color:
                              Get.isDarkMode ? Colors.teal : primaryLightClr),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
