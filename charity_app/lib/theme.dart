import 'package:charity_app/constaints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/number_symbols_data.dart';

class Themes {
  // light theme
  static final light = ThemeData(
    backgroundColor: Colors.white,
    primaryColor: primaryLightClr,
    primarySwatch: Colors.orange,
    brightness: Brightness.light,
  );
  // dark theme
  static final dark = ThemeData(
    backgroundColor: Colors.black,
    primaryColor: primaryDarkClr,
    brightness: Brightness.dark,
    primarySwatch: Colors.teal,
  );
}

TextStyle get subHeadingStyle {
  return (GoogleFonts.rubik(
    textStyle: TextStyle(
      fontSize: 24.sp,
      color: Get.isDarkMode ? Colors.grey[300] : Colors.black,
      fontWeight: FontWeight.w500,
    ),
  ));
}

TextStyle get headingStyle {
  return (GoogleFonts.rubik(
    textStyle: TextStyle(
      fontSize: 24.sp,
      color: Get.isDarkMode ? Colors.grey[300] : Colors.black,
      fontWeight: FontWeight.bold,
    ),
  ));
}

TextStyle get textHeadingStyle {
  return (GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 14.sp,
      color: Get.isDarkMode ? Colors.grey[300] : Colors.black,
      fontWeight: FontWeight.w500,
    ),
  ));
}

TextStyle get textInputStyle {
  return (GoogleFonts.rubik(
    textStyle: TextStyle(
      fontSize: 16.sp,
      color: Get.isDarkMode ? white : Colors.grey[800],
      fontWeight: FontWeight.w500,
    ),
  ));
}

TextStyle get hintStyle {
  return (GoogleFonts.rubik(
    textStyle: TextStyle(
      fontSize: 14.sp,
      color: Get.isDarkMode ? white : Colors.grey[600],
      fontWeight: FontWeight.w500,
    ),
  ));
}

TextStyle get quoteText {
  return (GoogleFonts.rubik(
    textStyle: TextStyle(
      fontSize: 16.sp,
      color: Get.isDarkMode ? Colors.teal : Colors.orange,
      fontWeight: FontWeight.w500,
    ),
  ));
}
