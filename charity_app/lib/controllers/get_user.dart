import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getmyUser();
  }

  final FirebaseFirestore _store = FirebaseFirestore.instance;
  DocumentSnapshot? data;

  Future<void> getmyUser() async {
    final myUser = await _store
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    data = myUser;

    update();
  }
}
