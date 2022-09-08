import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import '../../Model/add_donation_model.dart';

class FirebsaeMethods {
  // firebase firestore k methods fucntion
  // first to create the instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // instance

  Future<String> addDonation({
    required String title,
    required String name,
    required String quantity,
    required String category,
    required String description,
    required String pickUpLocation,
    required String donationDescription,
    required Uint8List attachment,
    required DateTime date,
  }) async {
    String res = "Some error occured";
    try {
      // creating and initailizing the add donotion model  here
      String photoUrl = await StorageMethods()
          .uploadImageToStorage("DonationItemPicture", attachment, true);
      AddDonationModel addDonationModel = AddDonationModel(
        id: FirebaseAuth.instance.currentUser!.uid,
        name: name,
        title: title,
        quantity: quantity,
        category: category,
        description: description,
        pickUpLocation: pickUpLocation,
        donationDescription: donationDescription,
        attachment: photoUrl,
        date: date,
        status: "pending",
      );

      String id = const Uuid().v1();
      // this is becasue q k ager user more then one entery karta hai
      // to woh sari enteries show hoon is lye id ka variable use kia aur us k lye  uuid package  install kia pub
      //pubspec.yaml file main
      await _firestore
          .collection("DonatedItems")
          .doc(id)
          .set(addDonationModel.toJson());
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}

class StorageMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // adding image to firebase storage
  Future<String> uploadImageToStorage(
    String childName,
    Uint8List file,
    bool ispost,
  ) async {
    // creating location to our firebase storage

    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);
    // putting in uint8list format -> Upload task like a future but not future
    if (ispost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }
    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snapshot = await uploadTask;

    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
