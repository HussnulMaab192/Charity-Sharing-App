import 'package:charity_app/Screens/DonorScreens/Active%20donations/active_donations.dart';
import 'package:charity_app/Screens/DonorScreens/view_request.dart';
import 'package:charity_app/controllers/get_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Screens/DonorScreens/My Donations/view_my_donations.dart';
import '../Screens/auth_screens/signin_screen.dart';
import '../constaints.dart';
import '../services/firebase_auth/firebase_auth.dart';
import '../../widgets/default_button.dart';

Widget MyDrawer(BuildContext context) {
  return Container(
    width: 250.h,
    child: Drawer(
      backgroundColor: Get.isDarkMode ? Colors.teal : primaryLightClr,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                color: Get.isDarkMode ? Colors.teal : Colors.white),
            accountName: Text(Get.find<UserController>().data!['name']),
            accountEmail: Text(Get.find<UserController>().data!['email']),
            currentAccountPicture: CircleAvatar(
              backgroundColor:
                  Get.isDarkMode ? primaryDarkBorderClr : primaryLightClr,
              child: const Text(
                "H",
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          // My Donations
          ListTile(
            leading: const Icon(Icons.handshake),
            title: const Text("My Doantions"),
            onTap: () {
              Get.to(const ViewMyDonations());
            },
          ),
          // Active Donations
          ListTile(
            leading: const Icon(Icons.notifications_active),
            title: const Text("Active Donations"),
            onTap: () {
              Get.to(const ActiveDonations());
            },
          ),

          //  Donate
          ListTile(
            leading: const Icon(Icons.grid_view),
            title: const Text("Donate"),
            onTap: () {
              Get.bottomSheet(BottomSheet(
                onClosing: () {},
                builder: (context) => SizedBox(
                  width: 150.w,
                  height: 190.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DefaultButton(
                          text: "Add Donation",
                          onPressed: () {
                            Get.back();
                            Get.back();
                          }),
                      SizedBox(
                        height: 20.h,
                      ),
                      DefaultButton(
                          text: "View Request",
                          onPressed: () {
                            Get.off(const ViewRequest());
                          }),
                    ],
                  ),
                ),
              ));
            },
          ),
          // Request
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Request"),
            onTap: () {
              Get.bottomSheet(BottomSheet(
                onClosing: () {},
                builder: (context) => SizedBox(
                  width: 150.w,
                  height: 190.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DefaultButton(
                          text: "Add Request",
                          onPressed: () {
                            Get.back();
                          }),
                      SizedBox(
                        height: 20.h,
                      ),
                      DefaultButton(
                          text: "View Active Donation", onPressed: () {}),
                    ],
                  ),
                ),
              ));
            },
          ),
          //volunteer
          ListTile(
            leading: const Icon(Icons.contacts),
            title: const Text("Volunteer"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          // Log out
          ListTile(
            leading: const Icon(Icons.contacts),
            title: const Text("Log out"),
            onTap: () async {
              Firebaseauth firebaseauth = Firebaseauth();
              String res = await firebaseauth.signOut();
              if (res == 'success') {
                Get.to(const SignIn());
              } else {
                return;
              }
            },
          ),
        ],
      ),
    ),
  );
}
