import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ElevatedButton DefaultButton({
  required String text,
  VoidCallback? onPressed,
  double? fontSize,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize ?? 10.sp,
        ),
      ),
    ),
  );
}
