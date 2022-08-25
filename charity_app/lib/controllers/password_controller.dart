import 'package:get/get.dart';

class PasswordCntroller extends GetxController {
  bool isSignUpObscure = true;
  bool isSignInObscure = true;

  // updating the value of sign up password

  void updateSignUpPasswordObscure() {
    isSignUpObscure = !isSignUpObscure;
    update();
  }

  void updateSignInPasswordObscure() {
    isSignInObscure = !isSignInObscure;
    update();
  }
}
