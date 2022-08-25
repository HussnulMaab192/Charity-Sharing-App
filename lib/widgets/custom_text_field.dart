import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget myTextField({
  required String hintText,
  required Icon preIcon,
  required TextEditingController mycontroller,
  String? Function(String?)? validator,
}) {
  return Column(
    children: [
      TextFormField(
        controller: mycontroller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
              fontSize: 16, fontFamily: "Rubik Medium", color: Colors.black),
          fillColor: Colors.orange,
          prefixIcon: preIcon,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.orange,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.orange,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        validator: validator,
      ),
      SizedBox(height: 14.h),
    ],
  );
}
