import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomTable extends StatelessWidget {
  final String name;
  final String quantity;
  final String category;
  final Widget actions;
  final bool? isHeader;

  const CustomTable({
    Key? key,
    required this.actions,
    required this.category,
    required this.name,
    required this.quantity,
    this.isHeader,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 50.h,
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                color: Get.isDarkMode ? Colors.teal : Colors.grey, width: 1)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0.r, horizontal: 0.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 50.w,
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: isHeader != null ? "Rubik Medium" : "",
                  color: isHeader != null
                      ? Get.isDarkMode
                          ? Colors.teal
                          : Colors.orange
                      : Get.isDarkMode
                          ? Colors.white
                          : Colors.black,
                ),
              ),
            ),
            Container(
              width: 1.0,
              height: double.maxFinite,
              decoration: BoxDecoration(
                color: isHeader != null
                    ? Get.isDarkMode
                        ? Colors.teal
                        : Colors.orange
                    : Get.isDarkMode
                        ? Colors.white
                        : Colors.black,
                border: Border.all(color: Colors.orange, width: 1),
              ),
            ),
            SizedBox(
              width: 50.w,
              child: Text(
                quantity,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: isHeader != null ? "Rubik Medium" : "",
                  color: isHeader != null
                      ? Get.isDarkMode
                          ? Colors.teal
                          : Colors.orange
                      : Get.isDarkMode
                          ? Colors.white
                          : Colors.black,
                ),
              ),
            ),
            Container(
              width: 1.0,
              height: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.orange,
                border: Border.all(color: Colors.orange, width: 1),
              ),
            ),
            SizedBox(
              width: 50.w,
              child: Text(
                category,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: isHeader != null ? "Rubik Medium" : "",
                  color: isHeader != null
                      ? Get.isDarkMode
                          ? Colors.teal
                          : Colors.orange
                      : Get.isDarkMode
                          ? Colors.white
                          : Colors.black,
                ),
              ),
            ),
            Container(
              width: 1.0,
              height: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.orange,
                border: Border.all(color: Colors.orange, width: 1),
              ),
            ),
            SizedBox(width: 50.w, child: actions)
          ],
        ),
      ),
    );
  }
}
