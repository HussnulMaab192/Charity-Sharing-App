import 'package:charity_app/Model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Firebaseauth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> createUser({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required String location,
  }) async {
    String res = "Some Error occured ";
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

// creating the user model object here
      UserModel user = UserModel(
        uid: credential.user!.uid,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        location: location,
      );
// creating the collection and setting it a value of UserModel
      await _firestore
          .collection("users")
          .doc(credential.user!.uid)
          .set(user.toJson());

      String isEmailVerified = await verifyEmail();

      if (isEmailVerified == "success") {
        res =
            "success"; // signUp say 1 email chali jay gi lakin sign in py redirect ho jay ga !
      } else {
        res = "success";
      }

// if collection is genertaed successfully and data is set to it then

    } catch (e) {
      // else any error occurs
      res = e.toString();
    }
    return res;
  }

  // here the sign up is completed and now the sign In

  Future<String> verifyEmail() async {
    String res = "Check Your Internet Connection";
    try {
      await _auth.currentUser!.sendEmailVerification();
      res = "success";
      res;
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> signIn({
    required String email,
    required String password,
  }) async {
// Function return the fucture Responce in String so
    String res = "Some Error occured ";

    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // if successfully signed in then
      if (!_auth.currentUser!.emailVerified) {
        await _auth.currentUser!.sendEmailVerification();
        Get.snackbar("Message", "Verify Your Email First");
      } else {
        res = "success";
      }
    } catch (e) {
      //else display the error!
      res = e.toString();
    }
    return res;
  }

  // signout

  Future<String> signOut() async {
    String res = "Some error Occured";
    try {
      await _auth.signOut();
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> forgetPassword({
    required String email,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar("Messsage", "Check Your Email to reset Your Password");
    } catch (e) {
      print(e.toString());
    }
  }
}
