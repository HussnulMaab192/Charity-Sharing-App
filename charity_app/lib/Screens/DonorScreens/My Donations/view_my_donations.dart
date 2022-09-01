import 'package:charity_app/widgets/app_logo_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../widgets/custom_card_for_mydoantion.dart';

class ViewMyDonations extends StatefulWidget {
  const ViewMyDonations({Key? key}) : super(key: key);

  @override
  State<ViewMyDonations> createState() => _ViewMyDonationsState();
}

class _ViewMyDonationsState extends State<ViewMyDonations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Donations"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppLogoText(title: "My Donations "),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("DonatedItems")
                    .where(
                      "id",
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid,
                    )
                    //  .orderBy("date", descending: true)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
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
                        final list = [];
                        for (var i = snapshot.data!.docs.length - 1;
                            i >= 0;
                            i--) {
                          list.add(i);
                        }
                        //  list.add(index);
                        return MyCustomCard(
                          snap: snapshot.data!.docs[list[index]].data(),
                        );
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
