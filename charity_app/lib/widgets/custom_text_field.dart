import 'package:charity_app/constaints.dart';
import 'package:charity_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget myTextField({
  VoidCallback? onTap,
  IconData? suffixIcon,
  bool? isObsecure,
  required String hintText,
  required IconData preIcon,
  required TextEditingController mycontroller,
  String? Function(String?)? validator,
  TextInputType? keyboardType,
}) {
  return Column(
    children: [
      TextFormField(
        keyboardType: keyboardType,
        obscureText: isObsecure ?? false,
        controller: mycontroller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: textInputStyle,
          suffixIcon: GestureDetector(
            onTap: onTap,
            child: Icon(
              suffixIcon,
              color: Get.isDarkMode ? Colors.teal : primaryLightClr,
            ),
          ),
          prefixIcon: Icon(
            preIcon,
            color: Get.isDarkMode ? Colors.teal : primaryLightClr,
          ),
          focusedBorder: outlineBorder(),
          enabledBorder: outlineBorder(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
          ),
        ),
        validator: validator,
      ),
      SizedBox(height: 14.h),
    ],
  );
}

OutlineInputBorder outlineBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: Get.isDarkMode ? Colors.teal : Colors.orange,
    ),
    borderRadius: BorderRadius.circular(20),
  );
}
