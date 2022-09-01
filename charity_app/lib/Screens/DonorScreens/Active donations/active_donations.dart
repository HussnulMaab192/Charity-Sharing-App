import 'package:charity_app/widgets/app_logo_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../widgets/custom_card_for_mydoantion.dart';

class ActiveDonations extends StatefulWidget {
  const ActiveDonations({Key? key}) : super(key: key);

  @override
  State<ActiveDonations> createState() => _ActiveDonationsState();
}

class _ActiveDonationsState extends State<ActiveDonations> {
  @override
  Widget build(BuildContext context) {
    final time = DateTime.now();
    DateTime tempTime;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            AppLogoText(),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("DonatedItems")
                  .where("status", isEqualTo: "pending")
                  .orderBy("date", descending: true)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      print(snapshot.data!.docs.length);
                      final list = [];

                      //  list.add(index);
                      return MyCustomCard(
                        snap: snapshot.data!.docs[index].data(),
                      );
                    });
              },
            ),
          ],
        ),
      )),
    );
  }
}
