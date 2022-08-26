import 'package:charity_app/constaints.dart';
import 'package:charity_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Column AppLogoText({String? title}) {
  return Column(
    children: [
      SizedBox(
        height: 24.h,
      ),
// APP-LOGO APP-TITLE-TEXT
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            height: 50.h,
            image: const AssetImage("assets/logo/donateLogo.jpg"),
          ),
          SizedBox(
            width: 10.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Charity Sharing",
                style: headingStyle,
              ),
              Text(
                "App",
                style: subHeadingStyle.copyWith(
                    color: Get.isDarkMode ? Colors.teal : primaryLightClr),
              ),
            ],
          )
        ],
      ),

      SizedBox(
        height: 20.h,
      ),
      // Add Donation Text
      Center(
        child: Text("${title ?? 'Add Your Donation '} ", style: headingStyle),
      ),

      SizedBox(
        height: 14.h,
      ),

      Center(
          child: Text(
        "Feeding some one is the highest \nReward you can give to humanity",
        textAlign: TextAlign.center,
        style: quoteText,
      )),
      SizedBox(
        height: 24.h,
      ),
    ],
  );
}
