import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class GetMyDonations extends GetxController {
  DocumentSnapshot? myDonationsData;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> getMyDoantions() async {
    final myDonations = await _firestore
        .collection("DonatedItems")
        .doc('RyDlna8hnZPnVfkQOzWUILVeAx92')
        .get();
    update();
  }
}
