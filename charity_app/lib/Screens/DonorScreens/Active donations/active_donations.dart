import 'package:charity_app/controllers/get_my_donations.dart';
import 'package:charity_app/widgets/app_logo_text.dart';
import 'package:charity_app/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class ActiveDonations extends StatefulWidget {
  const ActiveDonations({Key? key}) : super(key: key);

  @override
  State<ActiveDonations> createState() => _ActiveDonationsState();
}

class _ActiveDonationsState extends State<ActiveDonations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          AppLogoText(),
        ],
      )),
    );
  }
}
