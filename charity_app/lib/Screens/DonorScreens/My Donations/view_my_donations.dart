import 'package:charity_app/widgets/app_logo_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/get_my_donations.dart';
import '../../../widgets/default_button.dart';

class ViewMyDonations extends StatefulWidget {
  const ViewMyDonations({Key? key}) : super(key: key);

  @override
  State<ViewMyDonations> createState() => _ViewMyDonationsState();
}

class _ViewMyDonationsState extends State<ViewMyDonations> {
  @override
  Widget build(BuildContext context) {
    Get.put(GetMyDonations());
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          AppLogoText(title: "My Donations"),
          SizedBox(
            height: 30.h,
          ),
          DefaultButton(
              text: "Show My Donations",
              onPressed: () async {
                await Get.find<GetMyDonations>().getMyDoantions();
                print("after my donation button pressed !");
                //    print(Get.find<GetMyDonations>().myDonationsData!["name"]);
              }),
        ]),
      ),
    );
  }
}
