import 'package:charity/Screens/auth_screens/signin_screen.dart';
import 'package:charity/controllers/password_controller.dart';
import 'package:charity/services/firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please verify Your Email")));
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
              // logo + app name

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    height: 50.h,
                    image: const AssetImage("assets/logo/donateLogo.jpg"),
                  ),
                  SizedBox(
                    width: 10.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Charity Sharing",
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Rubik Medium',
                            color: Colors.black),
                      ),
                      Text(
                        "App",
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Rubik Medium',
                            color: Colors.orange),
                      ),
                    ],
                  )
                ],
              ),

              SizedBox(
                height: 20.h,
              ),
              // Sign Up Text
              const Center(
                  child: Text(
                "Sign Up",
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Rubik Medium',
                    color: Colors.black),
              )),

              SizedBox(
                height: 14.h,
              ),
              // quote text
              const Center(
                  child: Text(
                "Feeding some one is the highest \nReward you can give to humanity",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Rubik Regular',
                    color: Colors.orange),
              )),

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
                          preIcon: const Icon(Icons.person),
                          mycontroller: _nameController),
                      SizedBox(height: 10.h),

                      // Enter mobile no
                      myTextField(
                          hintText: "Enter Mobile number",
                          preIcon: const Icon(Icons.phone_android),
                          mycontroller: _mobileNumberController),
                      SizedBox(height: 10.h),

                      // Enter email
                      myTextField(
                          hintText: "Enter Email",
                          preIcon: const Icon(Icons.email),
                          mycontroller: _emailController),
                      SizedBox(height: 10.h),

                      // Enter Password
                      // Consumer<ObsecurePassword>(
                      //   builder: (context, value, child) => TextFormField(
                      //     controller: _passwordController,
                      //     obscureText: value.obsecure,
                      //     decoration: InputDecoration(
                      //       hintText: "Enter Password",
                      //       hintStyle: const TextStyle(
                      //           fontSize: 16,
                      //           fontFamily: 'Rubik Medium',
                      //           color: Colors.black),
                      //       fillColor: Colors.orange,
                      //       prefixIcon: const Icon(
                      //         Icons.lock,
                      //         color: Colors.orange,
                      //       ),
                      //       // const Icon(Icons.visibility,color: Colors.orange,),
                      //       suffixIcon: IconButton(
                      //         icon: const Icon(
                      //           Icons.visibility,
                      //           color: Colors.orange,
                      //         ),
                      //         onPressed: () {
                      //           value.checkMyObsecure();
                      //         },
                      //       ),
                      //       focusedBorder: OutlineInputBorder(
                      //         borderSide: const BorderSide(
                      //           color: Colors.orange,
                      //         ),
                      //         borderRadius: BorderRadius.circular(20),
                      //       ),
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(35),
                      //       ),
                      //       enabledBorder: OutlineInputBorder(
                      //         borderSide: const BorderSide(
                      //           color: Colors.orange,
                      //         ),
                      //         borderRadius: BorderRadius.circular(20),
                      //       ),
                      //     ),
                      //     validator: (value) {
                      //       if (value!.isEmpty) {
                      //         return "Enter Password First";
                      //       }
                      //       return null;
                      //     },
                      //   ),
                      // ),

                      GetBuilder<PasswordCntroller>(
                        builder: (pswdController) => TextFormField(
                          controller: _passwordController,
                          obscureText: pswdController.isSignUpObscure,
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
                                pswdController.updateSignUpPasswordObscure();
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

                      SizedBox(height: 10.h),

                      // choose location
                      myTextField(
                          hintText: "Choose location",
                          preIcon: const Icon(Icons.location_city_sharp),
                          mycontroller: _locationController),
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
                  : InkWell(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          registerUser();
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
                          child: Text("SignUp"),
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
                    "Already have an Account ?",
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
                              builder: (context) => const SignIn()));
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                          fontFamily: 'Rubik Medium',
                          color: Colors.orange),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
